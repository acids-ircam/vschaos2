import torch, torch.nn as nn, math
import pdb
from .base import Distribution


class Normal(Distribution):
    has_rsample = True

    def __init__(self, loc: torch.Tensor, scale: torch.Tensor):
        self._batch_shape = loc.size() 
        self._event_shape = torch.Size([0])
        assert loc.shape == scale.shape
        assert (scale > 0).all(), \
            "got negative or zero values for scale in Normal distribution with shape : %s"%(scale.shape,)
        self.loc, self.scale = loc, scale

    def __repr__(self):
        return "Normal(shape: %s)"%(self.loc.shape)
    
    @property 
    def mean(self):
        return self.loc

    @property
    def stddev(self):
        return self.scale

    @property
    def mode(self):
        return self.loc

    @property
    def variance(self):
        return self.stddev.pow(2)

    @property
    def _natural_params(self):
        return (self.loc / self.scale.pow(2), -0.5 * self.scale.pow(2).reciprocal())

    def sample(self):
        with torch.no_grad():
            return torch.normal(self.loc, self.scale)

    def rsample(self):
        return self.loc + torch.randn_like(self.scale) * self.scale

    def log_prob(self, value):
        var = (self.scale ** 2)
        log_scale = self.scale.log()
        return -((value - self.loc) ** 2) / (2 * var) - log_scale - math.log(math.sqrt(2 * torch.pi))