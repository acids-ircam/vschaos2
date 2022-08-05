import torch, os, dill, re
from os.path import join
from typing import List, Union
from omegaconf import OmegaConf
import acids_transforms as at
from .. import models

def get_versions(dirpath: str) -> Union[List[int], None]:
    dirs = list(filter(lambda x: os.path.isdir(join(dirpath, x)), os.listdir(dirpath)))
    version_dirs = list(filter(lambda x: re.match(r"version_\d+", x), dirs))
    if len(version_dirs) > 0:
        versions = list(map(lambda x: int(re.match(r"version_(\d+)", x).groups()[0]), version_dirs))
        return versions
    else:
        return None

def get_model_version(model_path, name=None):
    model_name = os.path.basename(model_path)
    if name is not None:
        if name[-3:] != ".vs":
            name += ".vs"
        model_path = join(model_path, name)
        assert os.path.isfile(model_path), f"{model_path} not found"
    else:
        if os.path.isfile(join(model_path, "last.vs")):
            model_path = join(model_path, "last.vs")
        elif os.path.isfile(join(model_path, f"{model_name}.vs")):
            model_path = join(model_path, f"{model_name}.vs")
        else:
            raise FileNotFoundError('could not retrieve model from path %s'%model_path)
    return model_path

def load_model_from_run(run_path, version=None, name=None, map_location=torch.device("cpu"), verbose: bool = False):
    run_name = os.path.basename(run_path)
    versions = get_versions(run_path)
    if versions is None:
        model_path = get_model_version(run_path, name=name)
        config_path = join(run_path, f"{run_name}.yaml")
        transform_path = join(run_path, f"{run_name}.ct")
        assert os.path.isfile(config_path), f"{config_path} not found"
        assert os.path.isfile(transform_path), f"{transform_path} not found"
    else:
        target_version = version or max(versions)
        run_path = join(run_path, f"version_{target_version}")
        model_path = get_model_version(run_path, name=name)
        config_path = join(run_path, f"{run_name}.yaml")
        transform_path = join(run_path, f"{run_name}.ct")
        assert os.path.isfile(config_path), f"{config_path} not found"
        assert os.path.isfile(transform_path), f"{transform_path} not found"
    if verbose:
        print('loading model path : %s\n\tconfig path : %s\n\ttransform path : %s'%(model_path, config_path, transform_path))

    config = OmegaConf.load(config_path)
    model_type = getattr(models, config.model.get('type', 'AutoEncoder'))
    model = model_type.load_from_checkpoint(model_path, map_location=map_location, strict=False)
    with open(transform_path, "rb") as f:
        transform = dill.load(f)
    return model, config, transform