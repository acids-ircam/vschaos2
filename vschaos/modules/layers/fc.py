import sys
sys.path.append('../')
import torch, torch.nn as nn
import numpy as np, math
from vschaos.modules import calculate_gain
from vschaos.utils import checklist, checktuple
from collections import OrderedDict
from . import norm_hash, dropout_hash
from typing import Union, Tuple, Iterable, Callable

DEFAULT_NNLIN = "ELU"

## Fully-connected layers & blocks
class WeightedLinear(nn.Module):
    def __init__(self, input_dim, output_dim, bias=True) -> None:
        """
        Fully-connected operation with weight normalization.
        Args:
            input_dim (int): input dimensionality
            output_dim (int): output dimensionality
            bias (bool): has bias (default: True)
        """
        super().__init__()
        self._weight = nn.Parameter(torch.zeros(output_dim, input_dim))
        nn.init.xavier_normal_(self._weight)
        self._weight_mul = nn.Parameter(torch.ones(1, 1))
        self.bias = None
        if bias:
            self.bias = nn.Parameter(torch.ones(output_dim))

    def __repr__(self):
        return f"WeightedLinear(in_features={self._weight.shape[1]}, "\
               f"out_features={self._weight.shape[0]}, "\
               f"bias={self.bias is not None})"

    @property
    def weight(self):
        return self._weight_mul * self._weight / self._weight.norm()

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return nn.functional.linear(x, self.weight, bias=self.bias)

linear_hash = {'linear': nn.Linear, 'weighted': WeightedLinear}

class MLPLayer(nn.Module):
    def __init__(self, input_dim: int, output_dim: int, norm: str = "batch", dropout: float = None, mode: str = "linear", bias=True, **kwargs):
        """
        Stackable fully-connected layers.
        Args:
            input_dim (int): input dimension
            output_dim (int): output dimension
            norm (str): normalization (default: "batch")
            dropout (float): dropout (default: None)
            mode (str): layer mode (options: linear, weighted, default: linear)
            bias (bool): has bias (default: True)
            **kwargs:
        """
        super().__init__()
        modules = OrderedDict()
        self.input_dim = input_dim; self.output_dim = output_dim
        self.linear = linear_hash[mode](int(np.prod(input_dim)), int(np.prod(output_dim)), bias=bias)
        if dropout is not None:
            self.dropout = dropout_hash[1](dropout)
        if norm is not None and norm != "none":
            self.norm = norm_hash[norm][1](output_dim)
        self.nnlin = kwargs.get('nnlin', DEFAULT_NNLIN)
        if self.nnlin is not None:
            if isinstance(self.nnlin, str):
                self.activation = getattr(nn, self.nnlin)()
            elif isinstance(self.nnlin, nn.Module):
                self.activation = self.nnlin
        self.modules = modules
        self._init_modules()

    def forward(self, x: torch.Tensor):
        out = self.linear(x)
        if hasattr(self, 'dropout'):
            out = self.dropout(out)
        if hasattr(self, 'norm'):
            out = self.norm(out)
        if hasattr(self, 'activation'):
            out = self.activation(out)
        return out

    @torch.jit.ignore
    def __call__(self, x: torch.Tensor, mod_closure: Callable = None):
        """
        Performs transformation.
        Inputs: 
            x (torch.Tensor): input tensor
            mod_closure(Callable): modulation callback before non-linearity
        """
        out = self.linear(x)
        if hasattr(self, 'dropout'):
            out = self.dropout(out)
        if hasattr(self, 'norm'):
            out = self.norm(out)
        if mod_closure is not None:
            out = mod_closure(out)
        if hasattr(self, 'activation'):
            out = self.activation(out)
        return out

    def _init_modules(self):
        if self.nnlin:
            gain = calculate_gain(self.nnlin, param=None)
        else:
            gain = 1.0
        torch.nn.init.xavier_uniform_(self.linear.weight, gain=gain)
        if self.linear.bias is not None:
            torch.nn.init.zeros_(self.linear.bias)


class BilinearLayer(nn.Module):
    def __init__(self, input_dim_1: int, input_dim_2: int, output_dim: int, norm: str = "batch", dropout: float = None, bias=True, **kwargs):
        """
        Bilinear transform layer.
        Args:
            input_dim (int): input dimension
            output_dim (int): output dimension
            norm (str): normalization (batch | instance | act, default: "batch")
            dropout (float): dropout (default: None)
            bias (bool): has bias (default: True)
            **kwargs:
        """
        super().__init__()
        modules = OrderedDict()
        self.input_dim_1 = input_dim_1; self.input_dim_2 = input_dim_2; self.output_dim = output_dim
        self.bilinear = nn.Bilinear(np.prod(input_dim_1), np.prod(input_dim_2), np.prod(output_dim), bias=bias)
        if dropout is not None:
            self.dropout = dropout_hash[1](dropout)
        if norm is not None:
            self.norm = norm_hash[norm][1](output_dim)
        self.nnlin = kwargs.get('nnlin', DEFAULT_NNLIN)
        if self.nnlin is not None:
            self.activation = getattr(nn, self.nnlin)()
        self.modules = modules
        self._init_modules()

    def forward(self, x1, x2, mod_closure=None):
        out = self.bilinear(x1, x2)
        if hasattr(self, 'dropout'):
            out = self.dropout(out)
        if hasattr(self, 'norm'):
            out = self.norm(out)
        if mod_closure is not None:
            out = mod_closure(out)
        if hasattr(self, 'activation'):
            out = self.activation(out)
        return out

    def _init_modules(self):
        if self.nnlin:
            gain = calculate_gain(self.nnlin, param=None)
        else:
            gain = 1.0
        torch.nn.init.xavier_uniform_(self.bilinear.weight, gain=gain)
        if self.bilinear.bias is not None:
            torch.nn.init.zeros_(self.bilinear.bias)


class GatedMLPLayer(nn.Module):
    def __init__(self, input_dim: int, output_dim: int, norm: str = "batch", dropout: float = None, bias=True, **kwargs):
        """
        Gated linear transform layer.
        Args:
            input_dim (int): input dimension
            output_dim (int): output dimension
            norm (str): normalization (default: "batch")
            dropout (float): dropout (default: None)
            bias (bool): has bias (default: True)
        """
        super(GatedMLPLayer, self).__init__()
        self.input_dim = input_dim; self.output_dim = output_dim
        self.linear = nn.Linear(np.prod(input_dim), np.prod(output_dim), bias=bias)
        self.mask = nn.Linear(np.prod(input_dim), np.prod(input_dim), bias=False)
        if dropout is not None:
            self.dropout = dropout_hash[1](dropout)
        if norm is not None:
            self.norm = norm_hash[norm][1](output_dim)
        self.nnlin = kwargs.get('nnlin', DEFAULT_NNLIN)
        if self.nnlin is not None:
            self.activation = getattr(nn, self.nnlin)()
        self._init_modules()

    def _init_modules(self):
        if self.nnlin:
            gain = calculate_gain(self.nnlin, param=None)
        else:
            gain = 1.0
        torch.nn.init.xavier_uniform_(self.linear.weight, gain=gain)
        torch.nn.init.xavier_uniform_(self.mask.weight, gain=gain)
        if self.linear.bias is not None:
            torch.nn.init.zeros_(self.linear.bias)

    def forward(self, x: torch.Tensor, mod_closure=None, **args) -> torch.Tensor:
        out = self.linear(x * torch.sigmoid(self.mask(x)))
        if hasattr(self, 'dropout'):
            out = self.dropout(out)
        if hasattr(self, 'norm'):
            out = self.norm(out)
        if mod_closure is not None:
            out = mod_closure(out)
        if hasattr(self, 'activation'):
            out = self.activation(out)
        return out

mlp_hash = {'simple': MLPLayer, 'gated': GatedMLPLayer}

class MLP(nn.Module):
    Layer = MLPLayer
    def __repr__(self):
        return self.module.__repr__()

    def __init__(self, input_dim: int, output_dim: int, nlayers: int = 1,
                 dim: int = 800, nnlin: str = DEFAULT_NNLIN, norm: str = "batch", bias=True, 
                 dropout: float = None, layer: str = "simple", mode: Union[str, Iterable[str]] = "linear", **kwargs):
        """
        Multi-Layer fully-connected module.
        Args:
            input_dim (int): input dimensions
            output_dim (int): output dimensions
            nlayers (int): number of layers (default: 1)
            hidden_dims (int): number of hidden units (default: 800)
            nnlin (str): non-linearity (default: "SiLU")
            norm (str): normalization (default: "batch")
            dropout (float): dropout rate (default: None)
            layer (str): layer type (simple | gated, default: gated)
            mode (str): layer mode (linear | weighted, default: linear)
        """
        super(MLP, self).__init__()
        self.input_dim = checktuple(input_dim)
        dims = [np.prod(input_dim)]+checklist(dim, n=nlayers)+[output_dim]
        layers = []
        layer_class = mlp_hash[layer]
        if isinstance(nnlin, list):
            assert len(nnlin) in (nlayers, nlayers+1)
            if len(nnlin) == nlayers:
                nnlin.append(None)
        else:
            nnlin = [nnlin] * nlayers + [None]
        dropout = checklist(dropout, n=len(dims))
        mode = checklist(mode, n=len(dims))
        bias = checklist(bias, n=len(dims))
        for i in range(len(dims)-1):
            current_norm = norm if i<len(dims)-2 else None
            layers.append(layer_class(dims[i], dims[i+1], nnlin=nnlin[i], norm=current_norm, dropout=dropout[i], bias=bias[i], mode=mode[i]))
        self.module = nn.Sequential(*tuple(layers))

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        out = x
        for i, mod in enumerate(self.module):
            out = mod(out)
        return out
        

    @torch.jit.ignore
    def __call__(self, x: torch.Tensor, mod_closure: Union[Callable, Iterable[Callable]]=None, \
                return_hidden: bool = False, trace: dict = None) -> Union[torch.Tensor, Tuple[torch.Tensor, Iterable[torch.Tensor]]]:
        """
        Performs MLP.
        Args: 
            x (torch.Tensor): input tensor
            mod_closure(Iterable[Callable]): single or list of modulation closures
            return_hidden (bool): return hidden vectors
            trace (dict): trace dictionary to populate
        """
        batch_size = x.shape[:-(len(self.input_dim))]
        out = x.reshape(np.prod(batch_size), -1)
        hidden = []
        if mod_closure is not None:
            mod_closure = checklist(mod_closure, len(self.module))
        for i, mod in enumerate(self.module):
            current_mod_closure = None if mod_closure is None else mod_closure[i]
            out = self.module[i](out, mod_closure=current_mod_closure)
            hidden.append(out.view(*batch_size, out.shape[-1]))
        if trace is not None:
            for i, h in enumerate(hidden):
                trace[f'layer_{i}'] = h

        out = out.view(*batch_size, out.shape[-1])
        if trace is not None: 
            trace['out'] = out
        if return_hidden:
            return out, hidden
        else:
            return out
