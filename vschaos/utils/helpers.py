import numpy as np, torch, torchaudio, os, re
from .misc import checklist
from functools import reduce
from typing import Dict
# import trajectories as tj
from tqdm import tqdm

valid_exts = [".mp3", ".m4a", ".wav", ".aif", ".aiff", ".ogg"]
def get_sounds(root: str = "sounds"):
    valid_files = []
    sounds = {}
    for r, d, f in os.walk(root):
        current_files = list(filter(lambda x: os.path.splitext(x)[1].lower() in valid_exts, f))
        valid_files.extend([os.path.join(root, f_tmp) for f_tmp in current_files])
    for f in tqdm(valid_files, total=len(valid_files), desc="importing files..."):
        filename = re.sub(root, "", f)
        sounds[filename] = torchaudio.load(f)
    return sounds

def apply_transform(data, transform, config):
    sound = data[0]
    sr = config.data.dataset.get('sr', 44100)
    if sr != data[1]:
        resample = torchaudio.transforms.Resample(data[1], sr)
        sound = resample(sound)
    data_transformed = transform(data[0])
    return data_transformed

def invert_transform(data, transform, config):
    sr = config.data.dataset.get('sr', 44100)
    data_inv = transform.invert(data)
    return data_inv, sr

"""
def stretch_trajectory(latent_traj: torch.Tensor, factor: float, t_range =  np.array([0., 1.]), dim: int = -2):
    n_steps = latent_traj.shape[0]
    t = np.linspace(0., 1., int(n_steps * factor))
    interp = tj.Interpolation_(t_range=t_range, trajectory=latent_traj.numpy())(t)
    return torch.from_numpy(interp).to(torch.get_default_dtype())

def interpolate_trajectories(trajectories, anchors, n_interp):
    target_shape = max([t.shape[-2] for t in trajectories])
    # stretch to maximum length
    for i, traj in enumerate(trajectories):
        t = np.linspace(0., 1., int(target_shape))
        interp = tj.Interpolation_(t_range=np.array([0., 1.]), trajectory=traj.numpy())(t)
        trajectories[i] = interp
    # interpolate
    t = np.linspace(0., 1., n_interp)
    traj = tj.Morphing_(trajectories=trajectories, anchors=anchors)(t)
    return traj
"""


def get_transferable_keys(models):
    names_set = []
    for i, m in enumerate(models):
        names_set.append(set([k for k, v in m.named_parameters()]))
    common_keys = list(reduce(lambda x, y: x.intersection(y), names_set))
    return list(sorted(common_keys))

def transfer_model(from_model, to_model, keys, verbose=False) -> None:
    common_keys = get_transferable_keys([from_model, to_model])
    keys = checklist(keys)
    transferred_keys = []
    for k in keys:
        transferred_keys.extend(filter(lambda x: re.match(k, x) is not None, common_keys))
    to_dict = to_model.state_dict()
    from_dict = from_model.state_dict()
    for k, v in to_dict.items():
        if k in transferred_keys:
            if to_dict[k].shape != from_dict[k].shape:
                if verbose:
                    print('shape for key %s not matching. not importing'%k)
            else:
                to_dict[k] = from_dict[k]
                if verbose:
                    print('import key %s'%k)
    to_model.load_state_dict(to_dict)

