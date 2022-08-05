import os
from omegaconf import OmegaConf
from . import utils
from . import data
from . import losses
from . import modules
from . import models
from .monitor import callbacks

def get_callbacks(config, rootdir="runs/"):
    if config is None:
        return []
    cks = []
    for callback in config:
        call_type = callback['type']
        call_args = callback.get("args", {})
        if call_type == "ModelCheckpoint":
            call_args['dirpath'] = rootdir
        cks.append(getattr(callbacks, call_type)(**call_args))
    return cks

# add resolvers
_runtime_dir = os.getcwd()
_home_dir = os.path.abspath("~")

def get_directory(name):
    if name == "runtime":
        return _runtime_dir
    elif name == "home":
        return _home_dir
    elif name == "current":
        return os.getcwd()
    elif name == "lib":
        return os.path.abspath(os.path.dirname(__file__) + "/..")
    else:
        raise ValueError("interpolating dir with value %s not implemented"%name)

OmegaConf.register_new_resolver("dir", lambda x: get_directory(x))
OmegaConf.register_new_resolver("abs", lambda x: os.path.abspath(x))
OmegaConf.register_new_resolver("base", lambda x: os.path.basename(x))
