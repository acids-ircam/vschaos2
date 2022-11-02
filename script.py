import argparse, torch, os, pdb
from vschaos.models.scriptable_ae import ScriptableSpectralAutoEncoder
from vschaos.utils.load import load_model_from_run

parser = argparse.ArgumentParser()
parser.add_argument('model', type=str, help="path of model directory")
parser.add_argument('-v', '--version', type=int, default=None, help="target version (default: last)")
parser.add_argument('-n', '--name', type=str, default=None, help="model name (default: last)")
parser.add_argument('-t', '--test', type=bool, default = 1, help="Test the model (default: True)")
parser.add_argument('-o', '--output', type=str, default="./", help="output location")
parser.add_argument('--verbose', type=int, default=0)
args = parser.parse_args()

# script model
model, config, transform = load_model_from_run(args.model, version=args.version, name=args.name, verbose=True)
model = model.eval()
scripted_model = ScriptableSpectralAutoEncoder(model, transform, inversion_mode="keep_input", use_oa=True, use_dimred=False)
print("model methods : ")
if args.verbose:
    scripted_model.print_params()

scripted_model = torch.jit.script(scripted_model)
print("model attributes : \n", scripted_model.get_attributes())
out_path = os.path.join(args.output, os.path.basename(args.model) + ".ts")

# check if file exists
if os.path.isfile(out_path):
    char = ""
    while not char in ['y', 'n']:
        char = input('file %s seems to exist. Remove (y/n)? ')
    if char == "y":
        os.remove(out_path)
    else:
        exit()

# save file
torch.jit.save(scripted_model, out_path)
print("model saved at : ", out_path)


# scripted_model.set_dimred('PCA')
# test script
if args.test:
    # y[k] = torch.randint(0, model.conditionings[k]['dim'], size=(2,16384))
    # test encode
    x = torch.zeros(2, scripted_model.encode_params[0], 16384)
    z_out = scripted_model.encode(x)
    if args.verbose:
        print("encode output shape : ", z_out.shape)
    # test decode
    z = torch.zeros(2, scripted_model.decode_params[0], z_out.shape[-1])
    x_out = scripted_model.decode(z)
    if args.verbose:
        print("decode output shape : ", x_out.shape)
    result = scripted_model.set_inversion_mode("keep_input")
    if args.verbose:
        print("set inversion mode result : ", result)
    # test forward
    x = torch.zeros(2, scripted_model.forward_params[0], 16384)
    out = scripted_model.forward(x)
    if args.verbose:
        print("forward out shape :", out.shape)


