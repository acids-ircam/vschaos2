import numpy as np, torch, argparse, os, tqdm, pdb
import torchaudio
from vschaos.distributions import Distribution
import trajectories as tj
from vschaos.utils.load import load_model_from_run

generate_tasks = ['reconstruct', 'morph', 'trajectories']

parser = argparse.ArgumentParser()
parser.add_argument('mode', type=str, help="generation mode", choices=generate_tasks)
parser.add_argument('path', type=str, help="model path")
parser.add_argument('--dataset', type=str, help="reference dataset (used to retrieve metadata)")
parser.add_argument('--meta', type=str, nargs="*", default=[], help="indicates metadata for conditioned model : TASK1 label1 TASK2 label2 ... ")
parser.add_argument('--sr', type=int, help="sample rate")
parser.add_argument("--cuda", type=int, default=None)
# General arguments
parser.add_argument('-b', '--n_batches', type=int, default=3)
parser.add_argument('-s', '--n_steps', type=int, default=512)
parser.add_argument('-o', '--out_path', type=str, default="outs/")
parser.add_argument('--sample_latent', type=int, default=0, help="sample latent from encoder (default: False)")
# Reconstruction arguments
parser.add_argument('-f', '--files', type=str, nargs="*", help="Reconstruction files (dirs or files)")
parser.add_argument("--jitter", type=float, default=None, help="add latent jitter to reconstruction")
# Trajectories arguments
parser.add_argument('--trajectories', type=str, nargs="*", default=["line", "sin", "random"])
args = parser.parse_args()

# Prepare output
if not os.path.isdir(args.out_path):
    os.makedirs(args.out_path)
outs = {}

# Prepare device
if args.cuda is None:
    device = torch.device('cpu')
else:
    device = torch.device("cuda:"+str(args.cuda))

model, config, transform = load_model_from_run(args.path, verbose=True)
model = model.to(device)
model = model.eval()

# Set sample rate
sr = None
if hasattr(model, "sr"):
    sr = model.sr
else:
    sr = args.sr
assert sr is not None, "sr not found in model; please provide sample rate with the --sr keyword"

y_enc = {}
y_dec = {}
if hasattr(model, "conditionings"):
    parsed_meta = {}
    assert len(args.meta) % 2 == 0, "--meta must be : task_1 val_1 task_2 val_2 ..."
    for i in range(0, len(args.meta), 2):
        parsed_meta[args.meta[i]] = args.meta[i+1]
    for task, info in model.conditionings.items():
        if info['embedding'] == 'OneHot':
            if task in parsed_meta:
                if args.mode == "reconstruct":
                    value = torch.LongTensor([[int(parsed_meta[task])]])
                elif args.mode == "trajectories":
                    value = torch.LongTensor([[int(parsed_meta[task])]]).repeat(args.n_batches, 1)
            else:
                if args.mode == "reconstruct":
                    value = torch.randint(0, info['dim'], (1, 1))
                elif args.mode == "trajectories":
                    value = torch.randint(0, info['dim'], (args.n_batches, 1))
        if 'encoder' in info['target']:
            y_enc[task] = value.to(device)
        if 'decoder' in info['target']:
            y_dec[task] = value.to(device)

# Process
if args.mode == "reconstruct":
    if not os.path.isdir(os.path.join(args.out_path, "reconstructions")):
        os.makedirs(os.path.join(args.out_path, "reconstructions"))
    assert args.files is not None, "--files arguments needed for reconstruction mode"
    # list files
    files = []
    for f in args.files:
        if os.path.isfile(f):
            files.append(f)
        elif os.path.isdir(f):
            for r, d, filelist in os.walk(f):
                for f_tmp in filelist:
                    if os.path.splitext(f_tmp)[1].lower() in [".wav", ".mp3", ".aif", ".aiff"]:
                        files.append(os.path.join(r, f_tmp))
    
    assert len(files) > 0, "no files found"
    # import files
    outs = {}
    for f in tqdm.tqdm(files, total=len(files), desc="forwarding samples..."):
        name = os.path.splitext(os.path.basename(f))[0]
        x_tmp, sr_tmp = torchaudio.load(f)
        if sr is not None:
            if sr != sr_tmp:
                x_tmp = torchaudio.functional.resample(x_tmp, sr_tmp, sr)
        x_tmp = transform(x_tmp)
        x_tmp = x_tmp.to(device)
        y_enc_tmp = {}
        y_dec_tmp = {}

        with torch.no_grad():
            if hasattr(model, "conditionings"):
                for k, v in y_enc.items():
                    y_enc_tmp[k] = v.repeat(1, x_tmp.shape[0])
            latent_tmp = model.encode(x_tmp.unsqueeze(0), y=y_enc_tmp)

            if args.sample_latent: 
                latent_tmp = latent_tmp.sample()
            else:
                latent_tmp = latent_tmp.mean
            if hasattr(model, "conditionings"):
                for k, v in y_dec.items():
                    if k in model.prediction_modules:
                        y_dec_tmp[k] = model.prediction_modules[k](latent_tmp).probs.argmax(-1)
                    else:
                        y_dec_tmp[k] = v.repeat(1, latent_tmp.shape[1])
            if args.jitter is None:
                x_tmp = model.decode(latent_tmp, y=y_dec_tmp)
            else:
                x_tmp = model.decode(latent_tmp + args.jitter * torch.randn_like(latent_tmp), y=y_dec_tmp)
        if isinstance(x_tmp, Distribution):
            x_tmp = x_tmp.mean
        x_tmp = transform.invert(x_tmp[0].cpu())
        if args.jitter is None:
            filename = os.path.join("reconstructions", f"{name}.wav")
        else:
            filename = os.path.join("reconstructions", name+f"_jitter={args.jitter}.wav")
        torchaudio.save(os.path.join(args.out_path, filename), x_tmp.cpu(), sample_rate=sr)

elif args.mode == "trajectories":
    args.out_path = os.path.join(args.out_path, "trajectories")
    if not os.path.isdir(args.out_path):
        os.makedirs(args.out_path)
    # compute trajectories
    tj.GLOBAL_DIM = model.config.latent.dim
    t_range = np.array([0., 1.])
    t = np.linspace(t_range[0], t_range[1], num=args.n_steps)[np.newaxis]
    t = np.repeat(t, args.n_batches, 0)

    # Here, select comment / uncomment the type of trajectories you want to 
    # generate. 
    for traj_type in args.trajectories:
        if traj_type == "line":
            traj = tj.Line_(t_range, [np.random.randn(args.n_batches, tj.GLOBAL_DIM), np.random.randn(args.n_batches, tj.GLOBAL_DIM)])
        elif traj_type == "sin":
            traj = tj.Sin_(freq=2.0, amplitude=np.random.uniform(-5, 5.0, size=(args.n_batches, tj.GLOBAL_DIM)),origin=np.random.randn(args.n_batches, tj.GLOBAL_DIM))
        elif traj_type == "square":
            traj = tj.Square_(freq=2.0, amplitude=np.random.uniform(-5, 5.0, size=(args.n_batches, tj.GLOBAL_DIM)),origin=np.random.randn(args.n_batches, tj.GLOBAL_DIM))
        elif traj_type == "ellipse":
            traj = tj.Ellipse_(t_range) 
        elif traj_type == "random":
            traj = tj.RandomWalk_(mean=0.0, stddev=0.2)
        else:
            print('trajectory %s not known'%traj_type)
            continue
        current_trajectory = torch.from_numpy(traj(t)).float()
        y_dec_tmp = {}
        for k, v in y_dec.items():
            y_dec_tmp[k] = v.repeat(1, current_trajectory.shape[1])
        decoded_traj = model.decode(current_trajectory.to(model.device), y=y_dec_tmp)
        if isinstance(decoded_traj, Distribution):
            decoded_traj = decoded_traj.mean
        x_reconstruction = transform.invert(decoded_traj.cpu())
        for i, rec in enumerate(x_reconstruction):
            if rec.max() > 1.0:
                rec = rec / rec.max()
            torchaudio.save(os.path.join(args.out_path, f"{traj_type}_{i}.wav"), rec, sample_rate=transform.sr)