from vschaos.utils.extract_pitch import extract_pitch
import torch, GPUtil as gpu, math, torchcrepe, torchaudio, argparse, os, re, tqdm
from os.path import join

parser = argparse.ArgumentParser()
parser.add_argument('input', type=str, help="dataset folder")
parser.add_argument('-c', '--threshold', type=float, help="periodicity threshold", default=1e-2)
parser.add_argument('-l', '--hop_length', type=int, default=256)
parser.add_argument('--fmin', type=float, default=50.)
parser.add_argument('--fmax', type=float, default=1000.)
parser.add_argument('--batch_size', type=int, default=256)
args = parser.parse_args()

extract_pitch(args.input, hop_length=args.hop_length, fmin=args.fmin, fmax=args.fmax, threshold=args.threshold, batch_size=args.batch_size)