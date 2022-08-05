import torch, torch.nn as nn
from typing import Union
from torch.nn.functional import binary_cross_entropy_with_logits, softmax
from .base import Distribution

__all__ = ["Categorical"]

def logits_to_probs(logits, is_binary: bool=False):
    if is_binary:
        return torch.sigmoid(logits)
    return softmax(logits, dim=-1)

def probs_to_logits(probs, is_binary: bool=False, eps: float=1.e-7):
    ps_clamped = probs.clamp(min=eps, max=1 - eps)
    if is_binary:
        return torch.log(ps_clamped) - torch.log1p(-ps_clamped)
    return torch.log(ps_clamped)

class Categorical(Distribution):
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
            self.logits = logits -  logits.logsumexp(dim=-1, keepdim=True)
            self.probs = logits_to_probs(logits, False)
            self._param = logits
            self._batch_shape = logits.shape[:-1]
        elif (logits is None):
            assert not (probs is None)
            self.probs = probs / probs.sum(-1, keepdim=True)
            self.logits = probs_to_logits(self.probs, False)#, 1.e-7)
            self._param = probs
            assert not (probs < 0.).any(), "found probs < 0."
            assert not (probs > 1.).any(), "found probs > 1."
            self._batch_shape = probs.shape[:-1]
        else:
            raise ValueError("whether probs or logits must be given in Bernoulli")
        self._event_shape = torch.Size([0])
    
    def __repr__(self):
        return "Categorical(shape: %s)"%(self.probs.shape)
    
    @property 
    def mean(self):
        return torch.full(self._extended_shape, torch.nan, dtype=self.probs.dtype, device=self.probs.device)

    @property
    def mode(self):
        return self.probs.argmax(-1)

    @property
    def _extended_shape(self):
        return self._batch_shape + torch.Size([self.probs.shape[-1]])

    @property
    def variance(self):
        return torch.full(self._extended_shape, torch.nan, dtype=self.probs.dtype, device=self.probs.device)

    def sample(self):
        probs_2d = self.probs.reshape(-1, self.probs.size(-1))
        samples_2d = torch.multinomial(probs_2d, 1, True).T
        return samples_2d.reshape(self._batch_shape)

    def log_prob(self, value):
        value = value.long().unsqueeze(-1)
        value = value[..., :1]
        return self.logits.gather(-1, value).squeeze(-1)

    @property
    def _natural_params(self):
        return (torch.log(self.probs / (1 - self.probs)),)

    def entropy(self):
        min_real = -3.4e38
        logits = torch.clamp(self.logits, min=min_real)
        p_log_p = logits * self.probs
        return -p_log_p.sum(-1)