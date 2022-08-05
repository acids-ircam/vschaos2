import re, os, dill, torch
from omegaconf import OmegaConf
from pytorch_lightning import LightningDataModule
from .. import models
from .misc import checkdir

def get_model_versions(models_path):
    name = os.path.basename(models_path)
    current_files = list(filter(lambda x: os.path.splitext(x)[1] == ".ckpt", os.listdir(models_path)))
    versions = list(filter(lambda x: x is not None, [re.match(f"{name}-v(\d+).ckpt", f) for f in current_files]))
    if len(versions) != 0:
        versions = list(map(int, [v[1] for v in versions]))
    return versions

def save_trainig_config(config: OmegaConf, data: LightningDataModule, path: str = None, name: str = None):
    """Saves training configurations and transforms in the training directory."""
    if path is None:
        path = config.rundir
    if name is None:
        name = config.name
    with open(os.path.join(path, f"{name}.yaml"), "w+") as f:
        f.write(OmegaConf.to_yaml(config))
    if hasattr(data, "full_transforms"):
        with open(os.path.join(path, f"{name}.ct"), 'wb') as f:
            dill.dump(data.full_transforms, f)
    
    