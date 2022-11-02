import  pdb, os, argparse
import logging
import torch, pytorch_lightning as pl, hydra
from pytorch_lightning.loggers import TensorBoardLogger
from omegaconf import OmegaConf, DictConfig
import GPUtil as gpu
from vschaos import data, models, get_callbacks
from vschaos.utils import save_trainig_config, get_root_dir
logger = logging.getLogger(__name__)

# detect CUDA devices
CUDA = gpu.getAvailable(maxMemory=.05)
VISIBLE_DEVICES = os.environ.get("CUDA_VISIBLE_DEVICES", "")
if VISIBLE_DEVICES:
    use_gpu = int(int(VISIBLE_DEVICES) >= 0)
elif len(CUDA):
    os.environ["CUDA_VISIBLE_DEVICES"] = str(CUDA[0])
    use_gpu = 1
elif torch.cuda.is_available():
    # print("Cuda is available but no fully free GPU found.")
    # print("Training may be slower due to concurrent processes.")
    use_gpu = 1
else:
    # print("No GPU found.")
    use_gpu = 0

@hydra.main(config_path="configs", config_name="config", version_base="1.2")
def main(config: DictConfig, ckpt_path=None):
    OmegaConf.set_struct(config, False)
    # import data
    config.data.loader['num_workers'] = config.data.loader.get('num_workers', os.cpu_count())
    data_module = getattr(data, config.data.module)(config.data)
    data_module.dataset[0]
    # import model
    config.model.input_shape = data_module.shape
    model = getattr(models, config.model.type)(config.model)
    # setup trainer
    trainer_config = config.get('pl_trainer', {})
    trainer_config['gpus'] = config.get('gpus', use_gpu)
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

if __name__ == "__main__":
    main()
