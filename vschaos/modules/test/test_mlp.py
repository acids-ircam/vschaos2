import pytest, sys, os, torch
if not "../" in sys.path:
    sys.path.insert(0, "../")
from active_divergence.modules import MLPEncoder, ConvEncoder
from omegaconf import OmegaConf

current_folder = os.path.dirname(os.path.abspath(__file__))+"/configs/mlp"
valid_config_ext = ['.yaml', '.yml', '.YAML', '.YML']
def get_configs():
    filelist = os.listdir(current_folder)
    valid_names=list(filter(lambda x: os.path.splitext(x)[1] in valid_config_ext, filelist))
    return valid_names
configs = get_configs()
batch_size = (4, 4)

@pytest.mark.parametrize("config_name", configs)
def test_forward(config_name):
    config_path = f"{current_folder}/{config_name}"
    config = OmegaConf.load(config_path)
    mlp = MLPEncoder(config)
    x = torch.zeros(*batch_size, config.input_shape)
    mlp.eval()
    mlp(x)
    mlp.train()
    out = mlp(x)

@pytest.mark.parametrize("config_name", configs)
def test_scriptable(config_name):
    config_path = f"{current_folder}/{config_name}"
    config = OmegaConf.load(config_path)
    mlp = MLPEncoder(config)
    mlp_scripted = torch.jit.script(mlp)
    x = torch.zeros(*batch_size, config.input_shape)
    out = mlp_scripted(x)