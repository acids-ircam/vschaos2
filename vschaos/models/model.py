import abc, re
import torch.nn as nn, pytorch_lightning as pl
from omegaconf import OmegaConf, ListConfig
from typing import Union, Dict, List
from ..utils import checklist

ConfigType = Union[Dict, OmegaConf]


class Model(pl.LightningModule):
    def __init__(self, config: dict = None):
        """
        Abstract method implementing several utility functions (regex-based checkpoint loading, device id)
        """
        super(Model, self).__init__()
        # load keys from external configs in case
        if config.get('config_checkpoint'):
            config = self.import_checkpoint_config(config.config_checkpoint)
            del config['config_checkpoint']
        self.config = config

    @property
    def device(self):
        return next(self.parameters()).device

    def import_checkpoint(self, config_checkpoint: Union[OmegaConf, List[OmegaConf], str]) -> None:
        """
        Import a checkpoint or a set of checkpoints. Checkpoint configuration may include:
            - path: checkpoint path
            - params: regex / list of regex for imported parameters
        Args:
            config_checkpoint (Union[OmegaConf, List[OmegaConf], str])): checkpoint configuration. If a single string,
                loads the model at the indicated path.
        """
        if isinstance(config_checkpoint, ListConfig):
            for c in config_checkpoint:
                self.import_checkpoint(c)
        else:
            if isinstance(config_checkpoint, str):
                config_checkpoint = OmegaConf.create({'path': config_checkpoint})
            model = self.load_from_checkpoint(config_checkpoint.path)
            model_params = dict(model.named_parameters())
            model_params_names = list(model_params.keys())
            if config_checkpoint.get('params'):
                params_to_import = []
                for target_params in checklist(config_checkpoint.params):
                    p = list(filter(lambda x: re.match(target_params, x), model_params_names))
                    params_to_import.extend(p)
            else:
                params_to_import = model_params_names
            current_params = dict(self.named_parameters())
            for param_name in params_to_import:
                if current_params[param_name].shape == model_params[param_name].shape:
                    print('loading paramater %s from %s...' % (param_name, config_checkpoint.path))
                    current_params[param_name] = model_params[param_name]
                else:
                    print('non-matching shape for parameter %s ; skipping' % param_name)
            try:
                self.load_state_dict(current_params, strict=True)
            except Exception as e:
                incompatible, unexpected = self.load_state_dict(current_params, strict=False)
                if len(incompatible) != 0:
                    print("Found incompatible keys :", incompatible)
                if len(unexpected) != 0:
                    print("Unexpected keys :", unexpected)

    def import_checkpoint_config(self, config: OmegaConf,
                                 config_checkpoint: Union[OmegaConf, List[OmegaConf]]) -> OmegaConf:
        """
        Import config entries from an external configuration file before model initialization.
        config_checkpoint configurations include :
        - config (str): paths of configuration to load
        - config_keys (List[str]): regexp for target configuration keys (default: None, loads all the config)
        Args:
            config (Config): main configuration
            config_checkpoint (Union[Config, List[Config]]): configs to import

        Returns:
            config (Config): updated config
        """
        if isinstance(config_checkpoint, ListConfig):
            for c in config_checkpoint:
                self.import_checkpoint_config(config, c)
        else:
            if config_checkpoint.get('config'):
                external_config = OmegaConf.load(config_checkpoint.config)
                if config_checkpoint.get('config_keys'):
                    for k in checklist(config_checkpoint.config_keys):
                        config[k] = external_config.model[k]
                else:
                    config = external_config.model
        return config

    def get_parameters(self, parameters: List[str]=None, model: nn.Module=None) -> List[nn.Parameter]:
        """
        Get list of parameters with regex indentifiers.
        Args:
            parameters (List[str]): list of regexp identifiers (default: None, returns full parameter list)
            model: model to retrieve parameters from (default: None, self)

        Returns:

        """
        model = model or self
        if parameters is None:
            params = model.parameters()
        else:
            full_params = dict(model.named_parameters())
            full_params_names = list(full_params.keys())
            params = []
            for param_regex in self.config.training.optim_params:
                valid_names = list(filter(lambda x: re.match(param_regex, x), full_params_names))
                params.extend([full_params[k] for k in valid_names])
        return params

    def save_config(self, config, *args):
        if config.get('checkpoint'):
            del config['checkpoint']
        super(Model, self).save_hyperparameters(config)

    def log_losses(self, loss_dict, period, **kwargs):
        for k, v in loss_dict.items():
            self.log(f"{k}/{period}", v, **kwargs)

    """
    ## Standardized functions
    @abc.abstractmethod
    def encode(self, *args, **kwargs):
        pass

    @abc.abstractmethod
    def decode(self, *args, **kwargs):
        pass

    @abc.abstractmethod
    def reconstruct(self, *args, **kwargs):
        pass

    @abc.abstractmethod
    def sample_from_prior(self, *args, **kwargs):
        pass

    @abc.abstractmethod
    def trace(self, *args, **kwargs) -> dict:
        pass
    """
