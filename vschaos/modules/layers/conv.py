#%% Convolutional ops
#_________________
### Weighted convs
import sys, pdb, math
sys.path.append('../')
import torch, torch.nn as nn
from torch import Tensor, ones
from torch.nn import Conv1d, Conv2d, Conv3d, ConvTranspose1d, ConvTranspose2d, ConvTranspose3d
import numpy as np
from vschaos.utils import checklist, checktuple
from . import dropout_hash, norm_hash, DEFAULT_NNLIN
from typing import Union, Tuple, List, Iterable, Callable, NoReturn, Optional


def check_conv_param(param, dim=1):
    if isinstance(param, np.ndarray):
        return tuple([int(t) for t in param])
    else:
        return tuple([int(t) for t in checklist(param, n=dim)])

### weighted convolutions
### Convolution Modules

class Conv1d(nn.Conv1d):
    def __init__(self, *args, equalized_lr=False, **kwargs):
        super(Conv1d, self).__init__(*args, **kwargs)
        self.equalized_lr = equalized_lr

    @torch.jit.export
    def __call__(self, input: Tensor) -> Tensor:
        return self.forward(input)

    def forward(self, input: Tensor) -> Tensor:
        weight = self.weight
        if self.training and self.equalized_lr:
            weight = weight * math.sqrt(2 / torch.numel(weight))
        return self._conv_forward(input, weight, self.bias)


class Conv2d(nn.Conv2d):
    def __init__(self, *args, equalized_lr=False, **kwargs):
        super(Conv2d, self).__init__(*args, **kwargs)
        self.equalized_lr = equalized_lr

    @torch.jit.export
    def __call__(self, input: Tensor) -> Tensor:
        return self.forward(input)

    def forward(self, input: Tensor) -> Tensor:
        weight = self.weight
        if self.training and self.equalized_lr:
            weight = weight * math.sqrt(2 / torch.numel(weight))
        return self._conv_forward(input, weight, self.bias)


class Conv3d(nn.Conv3d):
    def __init__(self, *args, equalized_lr=False, **kwargs):
        super(Conv3d, self).__init__(*args, **kwargs)
        self.equalized_lr = equalized_lr

    @torch.jit.export
    def __call__(self, input: Tensor) -> Tensor:
        return self.forward(input)

    def forward(self, input: Tensor) -> Tensor:
        weight = self.weight
        if self.training and self.equalized_lr:
            weight = weight * math.sqrt(2 / torch.numel(weight))
        return self._conv_forward(input, weight, self.bias)


class ConvTranspose1d(nn.ConvTranspose1d):
    def __init__(self, *args, equalized_lr=False, **kwargs):
        super(ConvTranspose1d, self).__init__(*args, **kwargs)
        self.equalized_lr = equalized_lr

    def forward(self, input: Tensor, output_size: Optional[List[int]] = None) -> Tensor:
        if self.padding_mode != 'zeros':
            raise ValueError('Only `zeros` padding mode is supported for ConvTranspose1d')
        assert isinstance(self.padding, tuple)
        output_padding = self._output_padding(
            input, output_size, self.stride, self.padding, self.kernel_size, 1, dilation=self.dilation)
        weight = self.weight
        if self.training and self.equalized_lr:
            weight = weight * math.sqrt(2 / torch.numel(weight))
        return nn.functional.conv_transpose1d(
            input, weight, self.bias, self.stride, self.padding,
            output_padding, self.groups, self.dilation)


class ConvTranspose2d(nn.ConvTranspose2d):
    def __init__(self, *args, equalized_lr=False, **kwargs):
        super(ConvTranspose2d, self).__init__(*args, **kwargs)
        self.equalized_lr = equalized_lr

    def forward(self, input: Tensor, output_size: Optional[List[int]] = None) -> Tensor:
        if self.padding_mode != 'zeros':
            raise ValueError('Only `zeros` padding mode is supported for ConvTranspose1d')
        assert isinstance(self.padding, tuple)
        output_padding = self._output_padding(
            input, output_size, self.stride, self.padding, self.kernel_size, 2, dilation=self.dilation)
        weight = self.weight
        if self.training and self.equalized_lr:
            weight = weight * math.sqrt(2 / torch.numel(weight))
        return nn.functional.conv_transpose2d(
            input, weight, self.bias, self.stride, self.padding,
            output_padding, self.groups, self.dilation)


class ConvTranspose3d(nn.ConvTranspose3d):
    def __init__(self, *args, equalized_lr=False, **kwargs):
        super(ConvTranspose3d, self).__init__(*args, **kwargs)
        self.equalized_lr = equalized_lr

    def forward(self, input: Tensor, output_size: Optional[List[int]] = None) -> Tensor:
        if self.padding_mode != 'zeros':
            raise ValueError('Only `zeros` padding mode is supported for ConvTranspose1d')
        assert isinstance(self.padding, tuple)
        output_padding = self._output_padding(
            input, output_size, self.stride, self.padding, self.kernel_size, 3, dilation=self.dilation)
        weight = self.weight
        if self.training and self.equalized_lr:
            weight = weight * math.sqrt(2 / torch.numel(weight))
        return nn.functional.conv_transpose3d(
            input, weight, self.bias, self.stride, self.padding,
            output_padding, self.groups, self.dilation)


class WeightedConv1d(nn.Conv1d):
    def __init__(self, *args, **kwargs):
        super(WeightedConv1d, self).__init__(*args, **kwargs)
        self.scale = nn.Parameter(torch.tensor(1.))

    def _get_normalized_weight(self):
        return self.scale * self.weight / self.weight.norm()

    def forward(self, input: Tensor) -> Tensor:
        weight = self._get_normalized_weight(self.weight)
        return self._conv_forward(input, weight, self.bias)


class WeightedConv2d(nn.Conv2d):
    def __init__(self, *args, **kwargs):
        super(WeightedConv1d, self).__init__(*args, **kwargs)
        self.scale = nn.Parameter(torch.tensor(1.))

    def _get_normalized_weight(self):
        return self.scale * self.weight / self.weight.norm()

    def forward(self, input: Tensor) -> Tensor:
        weight = self._get_normalized_weight(self.weight)
        return self._conv_forward(input, weight, self.bias)


class WeightedConv3d(nn.Conv3d):
    def __init__(self, *args, **kwargs):
        super(WeightedConv3d, self).__init__(*args, **kwargs)
        self.scale = nn.Parameter(torch.tensor(1.))

    def _get_normalized_weight(self):
        return self.scale * self.weight / self.weight.norm()

    def forward(self, input: Tensor) -> Tensor:
        weight = self._get_normalized_weight(self.weight)
        return self._conv_forward(input, weight, self.bias)


class WeightedConvTranspose1d(nn.ConvTranspose1d):
    def __init__(self, *args, **kwargs):
        super(WeightedConvTranspose1d, self).__init__(*args, **kwargs)
        self.scale = nn.Parameter(torch.tensor(1.))

    def _get_normalized_weight(self):
        return self.scale * self.weight / self.weight.norm()

    def forward(self, input: Tensor, output_size: Optional[List[int]] = None) -> Tensor:
        if self.padding_mode != 'zeros':
            raise ValueError('Only `zeros` padding mode is supported for ConvTranspose1d')
        assert isinstance(self.padding, tuple)
        # One cannot replace List by Tuple or Sequence in "_output_padding" because
        # TorchScript does not support `Sequence[T]` or `Tuple[T, ...]`.
        output_padding = self._output_padding(
            input, output_size, self.stride, self.padding, self.kernel_size, self.dilation)  # type: ignore[arg-type]
        weight = self._get_normalized_weight()
        return nn.functional.conv_transpose1d(
            input, weight, self.bias, self.stride, self.padding,
            output_padding, self.groups, self.dilation)


class WeightedConvTranspose2d(nn.ConvTranspose2d):
    def __init__(self, *args, **kwargs):
        super(WeightedConvTranspose2d, self).__init__(*args, **kwargs)
        self.scale = nn.Parameter(torch.tensor(1.))

    def _get_normalized_weight(self):
        return self.scale * self.weight / self.weight.norm()

    def forward(self, input: Tensor, output_size: Optional[List[int]] = None) -> Tensor:
        if self.padding_mode != 'zeros':
            raise ValueError('Only `zeros` padding mode is supported for ConvTranspose1d')
        assert isinstance(self.padding, tuple)
        # One cannot replace List by Tuple or Sequence in "_output_padding" because
        # TorchScript does not support `Sequence[T]` or `Tuple[T, ...]`.
        output_padding = self._output_padding(
            input, output_size, self.stride, self.padding, self.kernel_size, self.dilation)  # type: ignore[arg-type]
        weight = self._get_normalized_weight()
        return nn.functional.conv_transpose2d(
            input, weight, self.bias, self.stride, self.padding,
            output_padding, self.groups, self.dilation)


class WeightedConvTranspose3d(nn.ConvTranspose3d):
    def __init__(self, *args, **kwargs):
        super(WeightedConvTranspose3d, self).__init__(*args, **kwargs)
        self.scale = nn.Parameter(torch.tensor(1.))

    def _get_normalized_weight(self):
        return self.scale * self.weight / self.weight.norm()

    def forward(self, input: Tensor, output_size: Optional[List[int]] = None) -> Tensor:
        if self.padding_mode != 'zeros':
            raise ValueError('Only `zeros` padding mode is supported for ConvTranspose1d')
        assert isinstance(self.padding, tuple)
        # One cannot replace List by Tuple or Sequence in "_output_padding" because
        # TorchScript does not support `Sequence[T]` or `Tuple[T, ...]`.
        output_padding = self._output_padding(
            input, output_size, self.stride, self.padding, self.kernel_size, self.dilation)  # type: ignore[arg-type]
        weight = self._get_normalized_weight()
        return nn.functional.conv_transpose3d(
            input, weight, self.bias, self.stride, self.padding,
            output_padding, self.groups, self.dilation)


## Modulated convolutions (StyleGAN2-like)

eps = 1e-9
class ModConvTranspose2d(nn.ConvTranspose2d):
    def __init__(self, *args, mod_input=None, noise_amp=1.0, equalized_lr=False, **kwargs):
        super(ModConvTranspose2d, self).__init__(*args, **kwargs)
        in_channels = mod_input or kwargs.get('in_channels')
        self.affine_module = nn.Linear(in_channels, kwargs['in_channels'])
        self.noise_weight = self.get_noise_weight(kwargs['out_channels'])
        self.noise_amp = noise_amp
        self.equalized_lr = equalized_lr

    @property
    def std_dims(self):
        return (1, 3, 4)

    def get_noise_weight(self, out_channels):
        return nn.Parameter(torch.ones(1, out_channels,  1, 1))

    def _expand_mod(self, mod):
        return mod.view(mod.shape[0], mod.shape[1], 1, 1, 1)

    def _expand_demod(self, demod):
        return demod.view(demod.shape[0], 1, demod.shape[1], 1, 1)

    def _get_modulated_weight(self, input, mod):
        if mod is None:
            mod = torch.zeros(input.shape[0], self.affine_module.weight.shape[1]).to(input.device)
        mod = self.affine_module(mod)
        mod = self.weight.unsqueeze(0) * self._expand_mod(mod)
        mod_std = self._expand_demod((mod.pow(2).sum(self.std_dims) + eps).sqrt())
        mod = mod / mod_std
        if self.training and self.equalized_lr:
            mod = mod * math.sqrt(2 / (self.weight.numel()))
        return mod

    def _get_bias(self, out, noise):
        if noise is not None:
            bias = self.noise_weight * noise
        else:
            bias = self.noise_amp * self.noise_weight * torch.randn(out.shape[0], self.weight.shape[1], 1, 1).to(
                out.device)
        if self.bias is not None:
            bias = bias + self.bias.unsqueeze(0)
        return bias

    def forward(self, input: Tensor, mod: Tensor = None, noise: Tensor = None,
                output_size: Optional[List[int]] = None) -> Tensor:
        if self.padding_mode != 'zeros':
            raise ValueError('Only `zeros` padding mode is supported for ConvTranspose1d')
        assert isinstance(self.padding, tuple)
        # One cannot replace List by Tuple or Sequence in "_output_padding" because
        # TorchScript does not support `Sequence[T]` or `Tuple[T, ...]`.
        output_padding = self._output_padding(
            input, output_size, self.stride, self.padding, self.kernel_size, self.dilation)  # type: ignore[arg-type]
        weight = self._get_modulated_weight(input, mod)
        # weight = self._get_demodulated_weight(weight)
        weight = weight.view(weight.shape[0] * weight.shape[1], *weight.shape[2:])
        input_r = input.view(1, input.shape[0] * input.shape[1], *input.shape[2:])
        out = nn.functional.conv_transpose2d(input_r, weight, self.bias, self.stride, self.padding, output_padding,
                                             input.shape[0], self.dilation)
        out = out.view(input.shape[0], weight.shape[1], *out.shape[2:])
        # apply bias
        bias = self._get_bias(out, noise)
        out = out + bias
        return out



class ModConvTranspose1d(ModConvTranspose2d):
    @property
    def std_dims(self):
        return (1, 3)

    def get_noise_weight(self, out_channels):
        return nn.Parameter(torch.ones(1, out_channels, 1))

    def _expand_mod(self, mod):
        return mod.view(mod.shape[0], mod.shape[1], 1, 1)

    def _expand_demod(self, demod):
        return demod.view(demod.shape[0], 1, demod.shape[1], 1)

    def _get_bias(self, out, noise):
        if noise is not None:
            bias = self.noise_weight * noise
        else:
            bias = self.noise_amp * self.noise_weight * torch.randn(out.shape[0], self.weight.shape[1], 1).to(
                out.device)
        if self.bias is not None:
            bias = bias + self.bias.unsqueeze(0)
        return bias



conv_hash = {'conv': {1: Conv1d, 2: Conv2d, 3: Conv3d},
             'weighted': {1: WeightedConv1d, 2: WeightedConv2d, 3: WeightedConv3d}}
deconv_hash = {'conv': {1: ConvTranspose1d, 2: ConvTranspose2d, 3: ConvTranspose3d},
               'weighted': {1: WeightedConvTranspose1d, 2: WeightedConvTranspose2d,
                            3: WeightedConvTranspose3d},
               'mod': {1: ModConvTranspose1d, 2: ModConvTranspose2d}}
pooling_hash = {'avg': {1: nn.AvgPool1d, 2: nn.AvgPool2d, 3: nn.AvgPool3d},
                'max': {1: nn.MaxPool1d, 3: nn.MaxPool2d, 3: nn.MaxPool3d}}


#%% Convolutional Layers

class ConvLayer(nn.Module):
    conv_hash = conv_hash

    def __init__(self, channels: Tuple[int, int],
                 kernel_size: Union[List[int], int] = 7, stride: Union[List[int], int] = 1, dim: int = 2,
                 nnlin: str = DEFAULT_NNLIN, norm: bool = None, padding: Union[List[int], int] = None,
                 dilation: Union[List[int], int] = 1, dropout: float = None, bias: bool = True,
                 conv_class="conv", **kwargs):
        """
        Stackable convolutional layer.
        Args:
            channels: (in_channels:int , out_channels: int)
            kernel_size: kernel size (default: 7)
            stride: stride (default: 1)
            dim: input dimensionality (default: 2)
            nnlin: non linearity (default: SiLU)
            norm: normalization (default: None)
            padding: padding (default: None)
            dilation: dilation (default: 1)
            dropout: dropout (default: None)
            bias: has bias (default: True)
            conv_class: convolution type (options : "conv", "weighted")
        """
        super(ConvLayer, self).__init__()
        self.channels = channels
        self.kernel_size = check_conv_param(kernel_size, dim)
        if padding is None:
            padding = np.floor(np.array(self.kernel_size) / 2).astype(np.int16)
        self.padding = check_conv_param(padding, dim)
        self.dilation = check_conv_param(dilation, dim)
        self.stride = check_conv_param(stride, dim)
        self.dim = dim
        self.bias = bias
        self.conv_class = conv_class
        if kwargs.get('output_padding') is not None:
            if isinstance(kwargs['output_padding'], np.ndarray):
                kwargs['output_padding'] = tuple(checklist(kwargs['output_padding'].tolist()))
            else:
                kwargs['output_padding'] = tuple(checktuple(kwargs['output_padding']))
        # init module
        self._init_modules(self.conv_class, **kwargs)
        if dropout is not None:
            self.dropout = dropout_hash[dim](dropout)
        if norm is not None and norm != "none":
            self.norm = norm_hash[norm][dim](channels[1])
        if nnlin is not None:
            self.activation = getattr(nn, nnlin)()

    def _init_modules(self, conv_class, **kwargs) -> NoReturn:
        self.conv = self.conv_hash[conv_class][self.dim](in_channels=self.channels[0],
                                                         out_channels=self.channels[1],
                                                         kernel_size=tuple(self.kernel_size),
                                                         stride=tuple(self.stride),
                                                         padding=tuple(self.padding),
                                                         dilation=tuple(self.dilation),
                                                         bias=self.bias if self.bias is not None else False,
                                                         **kwargs)

        nn.init.xavier_normal_(self.conv.weight)
        if self.conv.bias is not None:
            nn.init.zeros_(self.conv.bias)
        if hasattr(self, "norm"):
            if isinstance(self.norm, (nn.BatchNorm1d, nn.BatchNorm2d, nn.BatchNorm3d)):
                nn.init.xavier_normal_(self.norm.weight)
                nn.init.zeros_(self.norm.bias)

    def input_shape(self, output_dim: Union[Iterable[int], int]) -> np.ndarray:
        """
        Returns layer's input shape required to obtain the target output shape.
        Args:
            output_dim (iterable[int]): target output shape

        Returns:
            input_dim (iterable[int]): required input shape
        """
        if not isinstance(output_dim, np.ndarray):
            output_dim = np.array(checklist(output_dim))
        stride = np.array(self.stride)
        padding = np.array(self.padding)
        dilation = np.array(self.dilation)
        kernel_size = np.array(self.kernel_size)
        return stride * (output_dim - 1) - 2 * padding + dilation * (kernel_size - 1) + 1

    def output_shape(self, input_dim: Union[Iterable[int], int]) -> np.ndarray:
        """
        Returns layer's output shape obtained with a given input shape.
        Args:
            input_dim (iterable[int]): shape of the data input

        Returns:
            output_dim (iterable[int]): obtained output shape
        """
        if not isinstance(input_dim, np.ndarray):
            input_dim = np.array(checklist(input_dim))
        stride = np.array(self.stride)
        padding = np.array(self.padding)
        dilation = np.array(self.dilation)
        kernel_size = np.array(self.kernel_size)        
        return np.floor((input_dim + 2 * padding - dilation * (kernel_size - 1) - 1) / stride + 1)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        """
        Performs convolution.
        Args:
            x (torch.Tensor): input tensor
            mod_closure (Callable): optional callback before non-linearity
            **kwargs: optional keyword arguments passed to convolutional op
        """
        out = self.conv(x)
        if hasattr(self, "dropout"):
            out = self.dropout(out)
        if hasattr(self, "norm"):
            out = self.norm(out)
        if hasattr(self, "activation"):
            out = self.activation(out)
        return out

    @torch.jit.ignore
    def __call__(self, x: torch.Tensor, mod_closure: Callable = None, **kwargs) -> torch.Tensor:
        """
        Performs convolution.
        Args:
            x (torch.Tensor): input tensor
            mod_closure (Callable): optional callback before non-linearity
            **kwargs: optional keyword arguments passed to convolutional op
        """
        out = self.conv(x, **kwargs)
        if hasattr(self, "dropout"):
            out = self.dropout(out)
        if hasattr(self, "norm"):
            out = self.norm(out)
        if mod_closure is not None:
            out = mod_closure(out)
        if hasattr(self, "activation"):
            out = self.activation(out)
        return out


class DeconvLayer(ConvLayer):
    conv_hash = deconv_hash

    def __init__(self, *args, **kwargs):
        """
        Stackable deconvolutional layer.
        channels: (in_channels:int , out_channels: int)
        kernel_size: kernel size (default: 7)
        stride: stride (default: 1)
        dim: input dimensionality (default: 2)
        nnlin: non linearity (default: SiLU)
        norm: normalization (default: None)
        padding: padding (default: None)
        dilation: dilation (default: 1)
        dropout: dropout (default: None)
        bias: has bias (default: True)
        conv_class: convolution type (options : "conv", "weighted")
        output_padding: output padding (default: 0)
        """
        if kwargs.get('output_padding') is None:
            kwargs['output_padding'] = (0,) * kwargs['dim']
        super(DeconvLayer, self).__init__(*args, **kwargs)
        self.output_padding = kwargs.get('output_padding')

    @classmethod
    def get_output_padding(cls, output_dim: Iterable[int], kernel_size: Union[int, Iterable[int]] = None,
                           padding: Union[int, Iterable[int]] = None,
                           dilation: Union[int, Iterable[int]] = None,
                           stride: Union[int, Iterable[int]] = None, **kwargs) -> Tuple[np.ndarray, np.ndarray]:
        """
        gets the output padding required to preserve a target output dimension
        Args:
            output_dim: target output dimension
            ks (int or tuple[int]): kernel size
            padding (int or tuple[int]): padding
            dilation (int or tuple[int]): dilation
            stride (int or tuple[int]): stride

        Returns:
            output_padding (tuple[int]): required output padding
            out_shape (tuple[int]): output shape
        """
        if padding is None:
            padding = np.floor(kernel_size / 2)
        out_shape = np.floor((np.array(output_dim) + 2 * padding - dilation * (kernel_size - 1) - 1) / stride + 1)
        reversed_shape = stride * (out_shape - 1) - 2 * padding + dilation * (kernel_size - 1) + 1
        # print(output_dim, reversed_shape, out_shape)
        return (output_dim - reversed_shape).astype(np.int16), out_shape

    def output_shape(self, input_dim: Union[Iterable[int], int]) -> np.ndarray:
        """
        Returns layer's input shape required to obtain the target output shape.
        Args:
            output_dim (iterable[int]): target output shape

        Returns:
            input_dim (iterable[int]): required input shape
        """
        return self.stride * (input_dim - 1) - 2 * self.padding + self.dilation * (
                    self.kernel_size - 1) + 1 + self.output_padding

    def input_shape(self, output_dim: Union[Iterable[int], int]) -> np.ndarray:
        """
        Returns layer's output shape obtained with a given input shape.
        Args:
            input_dim (iterable[int]): shape of the data input

        Returns:
            output_dim (iterable[int]): obtained output shape
        """
        if not isinstance(output_dim, np.ndarray):
            output_dim = np.array(checklist(output_dim))
        out_shape = np.floor((output_dim + 2 * self.padding - self.output_padding - self.dilation * (
                    self.kernel_size - 1) - 1) / self.stride + 1)
        return out_shape

    @torch.jit.ignore
    def __call__(self, x: torch.Tensor, **kwargs) -> torch.Tensor:
        """Performs deconvolution."""
        return super(DeconvLayer, self).forward(x, **kwargs)


class GatedConvLayer(ConvLayer):
    conv_hash = conv_hash

    def __init__(self, *args, nnlin="Tanh", **kwargs):
        """
        Stackable gated convolutional layer.
        Args:
            channels: (in_channels:int , out_channels: int)
            kernel_size: kernel size (default: 7)
            stride: stride (default: 1)
            dim: input dimensionality (default: 2)
            nnlin: non linearity (default: SiLU)
            norm: normalization (default: None)
            padding: padding (default: None)
            dilation: dilation (default: 1)
            dropout: dropout (default: None)
            bias: has bias (default: True)
            conv_class: convolution type (options : "conv", "weighted")
        """
        super(GatedConvLayer, self).__init__(*args, nnlin=nnlin, **kwargs)

    def _init_modules(self, conv_class, **kwargs):
        super(GatedConvLayer, self)._init_modules(conv_class, **kwargs)
        self.gate_conv = conv_hash[conv_class][self.dim](in_channels=self.channels[0],
                                                         out_channels=self.channels[1],
                                                         kernel_size=tuple(self.kernel_size.tolist()),
                                                         stride=tuple(self.stride.tolist()),
                                                         padding=tuple(self.padding.tolist()),
                                                         dilation=tuple(self.dilation.tolist()),
                                                         bias=self.bias if self.bias is not None else False,
                                                         **kwargs)
        nn.init.normal_(self.gate_conv.weight, 0.0, 0.02)
        if self.gate_conv.bias is not None:
            nn.init.zeros_(self.gate_conv.bias)
        if hasattr(self, "norm"):
            if isinstance(self.norm, (nn.BatchNorm1d, nn.BatchNorm2d, nn.BatchNorm3d)):
                nn.init.normal_(self.norm.weight, 1.0, 0.02)
                nn.init.zeros_(self.norm.bias)

    def forward(self, x: torch.Tensor, mod_closure=None, **kwargs) -> torch.Tensor:
        """
        Performs gated convolution.
        Args:
            x (torch.Tensor): input tensor
            mod_closure (Callable): optional callback before non-linearity
            **kwargs: optional keyword arguments passed to convolutional op
        """
        out = self.conv(x, **kwargs);
        gate_out = self.gate_conv(x, **kwargs)
        if hasattr(self, "dropout"):
            out = self.dropout(out)
            gate_out = self.dropout(gate_out)
        if hasattr(self, "norm"):
            out = self.norm(out)
        if mod_closure is not None:
            out = mod_closure(out)
        out = out * torch.sigmoid(gate_out)
        if hasattr(self, "activation"):
            out = self.activation(out)
        return 


class GatedDeconvLayer(DeconvLayer):
    conv_hash = deconv_hash