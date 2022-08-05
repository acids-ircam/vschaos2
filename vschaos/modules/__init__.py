from torch import sqrt, tensor
from torch.nn.init import calculate_gain as cg
import torch, torch.nn as nn
from typing import List, Union

def calculate_gain(nnlin, param=None):
    try:
        gain = cg(nnlin, param)
    except ValueError:
        if nnlin == "SiLU":
            gain  = sqrt(tensor(2.))
        else:
            gain = 1.0
        pass
    return gain


class Reshape(nn.Module):
    def __repr__(self):
        return "Reshape%s"%(self.target_shape,)
    def __init__(self, *args, incoming_dim=None):
        """
        A module reshaping incoming data into a target form.
        Args:
            *args: target shape
        """
        super(Reshape, self).__init__()
        self.target_shape = torch.Size([int(a) for a in args])
        self.incoming_dim = incoming_dim

    def forward(self, x: torch.Tensor, batch_shape: Union[None, List[int]] = None) -> torch.Tensor:
        if batch_shape is None:
            if self.incoming_dim:
                batch_shape = torch.Size(x.shape[:-self.incoming_dim])
            else:
                batch_shape = torch.Size(x.shape[:-len(self.target_shape)])
        return torch.reshape(x, batch_shape + self.target_shape)

class Unsqueeze(nn.Module):
    def __init__(self, dim: int):
        """
        A module unsqueezing incoming data among a given dimension.
        Args:
            dim (int): dimension index
        """
        super(Unsqueeze, self).__init__()
        self.dim = dim

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return torch.unsqueeze(x, self.dim)

from .activations import *
from .misc import *
from .dist import *
from .layers import *
from .encoders import *