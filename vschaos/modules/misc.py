import torch, torch.nn as nn, random
from ..utils import frame


class PhaseShuffle(nn.Module):
    def __init__(self, dim: int = -1, range=[-2, 2]) -> None:
        super().__init__()
        self.dim = dim
        self.range = range

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        roll_amount = random.randrange(self.range[0], self.range[1])
        return x.roll(roll_amount, self.dim)

