import argparse, torch, os, pdb
from .models.scriptable_ae import ScriptableSpectralAutoEncoder
from .utils.load import load_model_from_run

def script(model, transform, verbose=False): 
    # script model
    model = model.eval()
    scripted_model = ScriptableSpectralAutoEncoder(model, transform, inversion_mode="keep_input", use_oa=True, use_dimred=False)
    if verbose:
        print("model methods : ")
        scripted_model.print_params()
    scripted_model = torch.jit.script(scripted_model)
    return scripted_model

def test_scripted_model(scripted_model, verbose=False):
    x = torch.zeros(2, scripted_model.encode_params[0], 16384)
    z_out = scripted_model.encode(x)
    if verbose:
        print("encode output shape : ", z_out.shape)
    # test decode
    z = torch.zeros(2, scripted_model.decode_params[0], z_out.shape[-1])
    x_out = scripted_model.decode(z)
    if verbose:
        print("decode output shape : ", x_out.shape)
    result = scripted_model.set_inversion_mode("keep_input")
    if verbose:
        print("set inversion mode result : ", result)
    # test forward
    x = torch.zeros(2, scripted_model.forward_params[0], 16384)
    out = scripted_model.forward(x)
    if verbose:
        print("forward out shape :", out.shape)

    

