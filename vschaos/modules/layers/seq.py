import sys, pdb
sys.path.append('../')
import torch, torch.nn as nn
import numpy as np
from vschaos.utils import checktuple
from typing import Union, Tuple


class RNN(nn.RNN):
    def __init__(self, *args, **kwargs):
        """RNN module. Similar to torch.nn implementation, just force the batch_first argument and
        do not return the hidden vector by default."""
        super().__init__(*args, batch_first=True, **kwargs)

    def forward(self, *args, return_hidden: bool = True, **kwargs) -> Union[torch.Tensor, Tuple[torch.Tensor, torch.Tensor]]:
        out, h = super().forward(*args, **kwargs)
        if return_hidden:
            return out, h
        else:
            return out

class GRU(nn.GRU):
    def  __init__(self, input_dim: int, output_dim: int, nlayers=2, bidirectionnal=False, dropout=0.0, bias=True, **kwargs):
        """RNN module. Similar to torch.nn implementation, just force the batch_first argument and
        do not return the hidden vector by default."""
        self.input_dim = checktuple(input_dim)
        super().__init__(np.prod(input_dim), output_dim, num_layers=nlayers, dropout=dropout, bias=bias, batch_first = True) 

    def forward(self, *args, return_hidden=True, **kwargs) -> Union[torch.Tensor, Tuple[torch.Tensor, torch.Tensor]]:
        out, h = super(GRU, self).forward(*args, **kwargs)
        if return_hidden:
            return out, h
        else:
            return out

