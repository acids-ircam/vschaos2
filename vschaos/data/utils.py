import numpy as np, torch, torchaudio
from random import random

def random_angle(min_f=20, max_f=8000, sr=24000):
    """from RAVE, Antoine Caillon https://github.com/caillonantoine/RAVE"""
    min_f = np.log(min_f)
    max_f = np.log(max_f)
    rand = np.exp(random() * (max_f - min_f) + min_f)
    rand = 2 * np.pi * rand / sr
    return rand

def pole_to_z_filter(omega, amplitude=.9):
    """from RAVE, Antoine Caillon https://github.com/caillonantoine/RAVE"""
    z0 = amplitude * torch.exp(torch.tensor(omega) * 1j)
    a = torch.Tensor([1, -2 * z0.real, z0.abs()**2])
    b = torch.Tensor([z0.abs()**2, -2 * z0.real, 1])
    return a, b

def random_phase_mangle(x, min_f, max_f, amp, sr):
    """from RAVE, Antoine Caillon https://github.com/caillonantoine/RAVE"""
    angle = random_angle(min_f, max_f, sr)
    a, b = pole_to_z_filter(angle, amp)
    return torchaudio.functional.lfilter(x, a, b)