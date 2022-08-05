from .base import Distribution
import torch


class Uniform(Distribution):
    def __init__(self, low, high):
        assert low.shape == high.shape
        self.low = low
        self.high = high
        self._batch_shape = low.shape
        self._event_shape = torch.Size([0])

    def rsample(self):
        rand = torch.rand(self._batch_shape, dtype=self.low.dtype, device=self.low.device)
        return self.low + rand * (self.high - self.low)

    def sample(self):
        return self.rsample()
    
    def log_prob(self, value):
        lb = self.low.le(value).type_as(self.low)
        ub = self.high.gt(value).type_as(self.low)
        return torch.log(lb.mul(ub)) - torch.log(self.high - self.low)

    def cdf(self, value):
        result = (value - self.low) / (self.high - self.low)
        return result.clamp(min=0, max=1)

    def icdf(self, value):
        result = value * (self.high - self.low) + self.low
        return result

    def entropy(self):
        return torch.log(self.high - self.low)