import torch, random, numpy as np, sys, abc
sys.path.append('../')
from vschaos.utils import checklist
from vschaos.data.utils import random_phase_mangle
from typing import Tuple, Dict, Union

MetaType = Dict[str, torch.Tensor]
OutputType = Union[torch.Tensor, MetaType]

class AudioAugmentation(object):
    def __init__(self, prob: float=0.5, sr: int=None, bitrate: int=None):
        """
        A base class for audio augmentation objects.
        Args:
            prob (float): augmentation probability (default: 0.5)
            sr (int): sampling rate (default: None)
            bitrate (int): bitrate (default: None)
        """
        self.prob = prob
        self.sr = sr
        self.bitrate = bitrate

    @abc.abstractmethod
    def augment(self, x, y=None):
        raise NotImplementedError

    def __call__(self, x: torch.Tensor, y: dict) -> Tuple[torch.Tensor, Dict]:
        """
        AudioAugmentation calls callback "augment" with the given probability.
        Args:
            x (torch.Tensor): incoming tensor
            y (dict): incoming metadata

        Returns:

        """
        if random.random() < self.prob:
            return self.augment(x, y=y)
        else:
            return x, y


# RAW WAVEFORM AUGMENTATIONS
class RandomPhase(AudioAugmentation):
    def __init__(self, fmin: float=20., fmax: float=2000., amp: float=.99, **kwargs):
        """
        Randomize the phase of an incoming raw audio chunk.
        Args:
            fmin(float): minimum frequency (default: 20)
            fmax (float): maximum frequency (default: 2000)
            amp (float): noise amplitude (default: 0.99)
            **kwargs:
        """
        super(RandomPhase, self).__init__(**kwargs)
        self.fmin = fmin
        self.fmax = fmax
        self.amp = amp

    def augment(self, x: torch.Tensor, y=None, **kwargs) -> Tuple[torch.Tensor, Dict]:
        x = random_phase_mangle(x, self.fmin, self.fmax, self.amp, self.sr)
        return x, y


class Dequantize(AudioAugmentation):
    """from RAVE, Antoine Caillon https://github.com/caillonantoine/RAVE"""
    def __init__(self, prob: float=1.0, **kwargs):
        """
        Dequantize incoming raw audio chunk.
        Args:
            prob: dequantization probability (default: 1.0)
            **kwargs: AudioAugmentation keywords
        """
        super(Dequantize, self).__init__(prob=prob, **kwargs)

    def augment(self, x: torch.Tensor, y: dict=None) -> Tuple[torch.Tensor, Dict]:
        x += np.random.rand(len(x)) / 2**self.bitrate
        return x, y


class Shift(AudioAugmentation):
    def __init__(self, roll_range=[-2, 2], prob=0.5):
        super(Shift, self).__init__(prob=prob)
        self.roll_range = roll_range
        self.prob = prob

    def augment(self, x, **kwargs):
        if isinstance(x, list):
            return [self(x_tmp, **kwargs) for x_tmp in x]
        shift = torch.randint(self.roll_range[0], self.roll_range[1], (1,)).item()
        if shift > 0:
            x = torch.cat([torch.zeros((*x.shape[:-1], shift)), x[..., :-shift]], -1)
        elif shift < 0:
            x = torch.cat([x[..., abs(shift):], torch.zeros((*x.shape[:-1], abs(shift)))], -1)
        if kwargs.get("y") is None:
            return x
        else:
            return x, kwargs.get('y')


class Normal(AudioAugmentation):
    valid_modes = ["amplitude", "bias"]

    def __init__(self, amp_range=0.05, mode="amplitude", dims=0, clamp=None, prob=0.5):
        super(Normal, self).__init__(prob=prob)
        self.amp_range = amp_range
        assert mode in self.valid_modes
        self.mode = mode
        self.dims = checklist(dims)
        if clamp is not None:
            clamp[0] = None if clamp[0] == "none" else float(clamp[0])
            clamp[1] = None if clamp[1] == "none" else float(clamp[1])
        self.clamp = clamp

    def augment(self, x: torch.Tensor, y: MetaType = None, **kwargs) -> OutputType:
        if isinstance(x, list):
            return [self(x_tmp, **kwargs) for x_tmp in x]
        noise_shape = [1] * x.ndim
        for i in self.dims:
            noise_shape[i] = x.shape[i]
        noise = self.amp_range * torch.randn(noise_shape, device=x.device, dtype=x.dtype)
        if self.mode == "amplitude":
            x = x * noise
        elif self.mode == "bias":
            x = x + noise
        if self.clamp is not None:
            x = torch.clamp(x, self.clamp[0], self.clamp[1])
        return x, y
        
        


