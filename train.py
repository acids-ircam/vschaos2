import sys
import hydra
from argparse import ArgumentParser
from omegaconf import DictConfig
from vschaos.train import train, resume

@hydra.main(config_path="configs", config_name="config", version_base="1.2")
def main(config: DictConfig, ckpt_path=None):
    train(config)

def resume_cli():
    parser = ArgumentParser()
    parser.add_argument('resume')
    parser.add_argument('-m', '--model', type=str, help="path to the folder")
    parser.add_argument('-v', '--version', type=int, help="number of the version")
    parser.add_argument('-d', '--dataset', type=str, help="dataset path")
    parser.add_argument('-n', '--name', type=str, help="name of the model.ckpt")
    parser.add_argument('--verbose', help="verbose mode")
    args = parser.parse_args()

    resume(args.model, dataset_path=args.dataset, version=args.version, name=args.name, verbose=args.verbose)    

if __name__ == "__main__":
    if sys.argv[1] == "resume":
        resume_cli()
    else:
        main()
