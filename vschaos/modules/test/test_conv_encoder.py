import pytest, sys, os, torch
if not "../" in sys.path:
    sys.path.insert(0, "../")
from active_divergence.modules import ConvEncoder
from omegaconf import OmegaConf

current_folder = os.path.dirname(os.path.abspath(__file__))+"/configs/conv_encoder"
valid_config_ext = ['.yaml', '.yml', '.YAML', '.YML']
def get_configs():
    filelist = os.listdir(current_folder)
    valid_names=list(filter(lambda x: os.path.splitext(x)[1] in valid_config_ext, filelist))
    return valid_names
configs = get_configs()
batch_size = (4, 4)

reshape_methods = ["none", "flatten", "channel"]
dims = [1, 2, 3]
input_chans = 2
data_dim = 32
target_dim = 2

@pytest.mark.parametrize("config_name", configs)
@pytest.mark.parametrize("reshape_method", reshape_methods)
@pytest.mark.parametrize("dim", dims)
def test_forward(config_name, reshape_method, dim):
    config_path = f"{current_folder}/{config_name}"
    config = OmegaConf.load(config_path)
    config["reshape_method"] = reshape_method
    if reshape_method != "none":
        config["target_shape"] = target_dim
    config["input_shape"] = (input_chans, *(data_dim,)*dim)
    config["dim"] = dim
    conv = ConvEncoder(config)
    x = torch.zeros(*batch_size, *config.input_shape)
    conv.eval()
    conv(x)
    conv.train()
    out = conv(x)

@pytest.mark.parametrize("config_name", configs)
@pytest.mark.parametrize("reshape_method", reshape_methods)
@pytest.mark.parametrize("dim", dims)
def test_scriptable(config_name, reshape_method, dim):
    config_path = f"{current_folder}/{config_name}"
    config = OmegaConf.load(config_path)
    config["reshape_method"] = reshape_method
    if reshape_method != "none":
        config["target_shape"] = 128
    config["dim"] = dim
    config["input_shape"] = (input_chans, *(data_dim,)*dim)
    conv = ConvEncoder(config)
    conv_scripted = torch.jit.script(conv)
    x = torch.zeros(*batch_size, input_chans, *config.input_shape)
    out = conv_scripted.forward(x)