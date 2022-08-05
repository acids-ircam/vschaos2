import torch, torch.nn as nn
from typing import Union
from torch.nn.functional import binary_cross_entropy_with_logits, softmax
from .base import Distribution

__all__ = ["Bernoulli"]

def logits_to_probs(logits, is_binary: bool=False):
    if is_binary:
        return torch.sigmoid(logits)
    return softmax(logits, dim=-1)

def probs_to_logits(probs, is_binary: bool=False, eps: float=1.e-7):
    ps_clamped = probs.clamp(min=eps, max=1 - eps)
    if is_binary:
        return torch.log(ps_clamped) - torch.log1p(-ps_clamped)
    return torch.log(ps_clamped)


class Bernoulli(Distribution):
    def __init__(self,
                probs: Union[torch.Tensor, None]=None,
                logits: Union[torch.Tensor, None]=None):
        self.logits = torch.tensor(0)
        self.probs = torch.tensor(0)
        self._param = torch.tensor(0)
        self._batch_shape = torch.Size([0])
        self._event_shape = torch.Size([0])
        if (probs is None):
            assert not (logits is None)
            self.logits = logits
            self.probs = logits_to_probs(logits, True)
            self._param = logits
            self._batch_shape = logits.size() 
        elif (logits is None):
            assert not (probs is None)
            self.probs = probs
            self.logits = probs_to_logits(probs, True, 1.e-7)
            self._param = probs
            assert not (probs < 0.).any(), "found probs < 0."
            assert not (probs > 1.).any(), "found probs > 1."
            self._batch_shape = probs.size() 
        else:
            raise ValueError("whether probs or logits must be given in Bernoulli")
        self._event_shape = torch.Size([0])

    def __repr__(self):
        return "Bernoulli(shape: %s)"%(self.probs.shape)
    
    @property 
    def mean(self):
        return self.probs

    @property
    def mode(self):
        mode = (self.probs >= 0.5).to(self.probs)
        mode[self.probs == 0.5] = torch.nan
        return mode

    @property
    def variance(self):
        return self.probs * (1 - self.probs)

    def sample(self):
        with torch.no_grad():
            return torch.bernoulli(self.probs)

    def log_prob(self, value):
        return -binary_cross_entropy_with_logits(self.logits, value, reduction='none')

    @property
    def _natural_params(self):
        return (torch.log(self.probs / (1 - self.probs)), )

    def entropy(self):
        return binary_cross_entropy_with_logits(self.logits, self.probs, reduction='none')