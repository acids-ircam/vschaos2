import pytest, os, sys
print(sys.path)
sys.path.insert(0, ".")
from active_divergence.modules import MLPEncoder, ConvEncoder

current_folder = os.path.dirname(os.path.abspath(__file__))
_module_test_configs = {
    MLPEncoder: f"{current_folder}/configs/MLP",
    ConvEncoder: f"{current_folder}/configs/ConvEncoder"
}

@pytest.fixture
def get_lp_encoder_configs():
    filelist = os.listdir(_module_test_configs[MLPEncoder])
    filelist = list(filter(lambda x: os.path.splitext(x)[1] in valid_config_ext), filelist)
    return filelist