import  pdb, os, argparse
from pathlib import Path
import dill
import logging
import torch, pytorch_lightning as pl, hydra
from pytorch_lightning.loggers import TensorBoardLogger
from omegaconf import OmegaConf, DictConfig
import GPUtil as gpu
from vschaos import data, models, get_callbacks
from vschaos.utils import save_trainig_config, get_root_dir, load_model_from_run, get_paths_from_run
logger = logging.getLogger(__name__)

def get_default_devices(config):
    try:
        cuda_available = torch.cuda.is_available()
    except: 
        cuda_available = False
    try:
        mps_available = torch.mps.device_count() > 0
    except: 
        mps_available = False

    accelerator = config.get('accelerator') or ("cuda" if cuda_available else ("mps" if mps_available else "cpu"))
    devices = config.get('devices') or 1

    if accelerator == "gpu": 
        if not cuda_available:
            logging.warning("accelerator set to gpu but cuda is not available ; moving to CPU")
            accelerator = "cpu"
    elif accelerator == "mps":
        if not mps_available:
            logging.warning("accelerator set to gpu but cuda is not available ; moving to CPU")
            accelerator = "cpu"
    return accelerator, devices


def train(config: DictConfig):
    OmegaConf.set_struct(config, False)

    # import data
    config.data.loader['num_workers'] = config.data.loader.get('num_workers', os.cpu_count())
    data_module = getattr(data, config.data.module)(config.data)
    # data_module.dataset[0]
    # import model
    config.model.input_shape = data_module.shape
    model = getattr(models, config.model.type)(config.model)

    # setup trainer
    trainer_config = config.get('pl_trainer', {})
    accelerator, devices = get_default_devices(trainer_config)
    trainer_config['accelerator'] = accelerator
    trainer_config['devices'] = devices  
    
    trainer_config['default_root_dir'] = get_root_dir(config.rundir, config.name)
    # import callbacks
    callbacks = get_callbacks(config.get('callbacks'), trainer_config['default_root_dir'])
    logger = TensorBoardLogger(save_dir=os.path.join(trainer_config['default_root_dir']), version="")
    trainer = pl.Trainer(**trainer_config, callbacks=callbacks, logger=logger)
    if bool(config.get('check')):
        pdb.set_trace()
    # train!
    save_trainig_config(config, data_module, path=trainer_config['default_root_dir'])
    trainer.fit(model, datamodule=data_module)


def resume(model_path, dataset_path, version=None, name="last.ckpt", verbose: bool = False):
    ckpt_path, config_path, transform_path = get_paths_from_run(model_path, version=version, name=name, verbose=verbose)
    config = OmegaConf.load(str(config_path))

    config.rundir = str(Path(model_path).parent)
    config.data.loader['num_workers'] = config.data.loader.get('num_workers', os.cpu_count())
    config.data.dataset.root = dataset_path
    data_module = getattr(data, config.data.module)(config.data)

    model = getattr(models, config.model.type)(config.model)
    with open(transform_path, "rb") as f:
        transform = dill.load(f)

    trainer_config = config.get('pl_trainer', {})
    accelerator, devices = get_default_devices(trainer_config)
    trainer_config['accelerator'] = accelerator
    trainer_config['devices'] = devices  
    trainer_config['default_root_dir'] = model_path

    # import callbacks
    trainer = pl.Trainer(**trainer_config)
    if bool(config.get('check')):
        pdb.set_trace()
    # train!
    trainer.fit(model, ckpt_path=ckpt_path, datamodule=data_module)
