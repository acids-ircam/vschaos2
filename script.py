import argparse, torch, os, pdb
from vschaos.utils.load import load_model_from_run
from vschaos.script import script, test_scripted_model

parser = argparse.ArgumentParser()
parser.add_argument('model', type=str, help="path of model directory")
parser.add_argument('-v', '--version', type=int, default=None, help="target version (default: last)")
parser.add_argument('-n', '--name', type=str, default="last", help="model name (default: last)")
parser.add_argument('-t', '--test', action="store_true", default = False, help="Test the model (default: True)")
parser.add_argument('-o', '--output', type=str, default="./", help="output location")
parser.add_argument('--verbose', type=int, default=0)
args = parser.parse_args()

model, config, transform = load_model_from_run(args.model, version=args.version, name=args.name, verbose=True)
scripted_model = script(model=model, transform=transform, verbose=args.verbose)

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
if not os.path.isdir(os.path.dirname(out_path)):
    os.makedirs(os.path.dirname(out_path))
torch.jit.save(scripted_model, out_path)
print("model saved at : ", out_path)

    # test script
if args.test:
    test_scripted_model(scripted_model, verbose=args.verbose)