import numpy as np, torch, torch.nn as nn

class ScaledSoftSign(nn.Module):
    def __init__(self):
        """Scaled Softsign activation, sometimes used in multi-head inversion models."""
        super().__init__()
        self.a = nn.Parameter(torch.ones(1))
        self.b = nn.Parameter(torch.ones(1))

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        shape = x.shape
        a = self.a.__getitem__((np.newaxis,) * (len(shape) - 1))
        b = self.b.__getitem__((np.newaxis,) * (len(shape) - 1))
        return (a * x) / (1 + torch.abs(b * x))