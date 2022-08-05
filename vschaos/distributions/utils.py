import torch.distributions as tdist
from .normal import Normal

def convert_to_torch(distribution):
    if isinstance(distribution, Normal):
        return tdist.Normal(distribution.mean, distribution.stddev)
    else:
        raise NotImplementedError