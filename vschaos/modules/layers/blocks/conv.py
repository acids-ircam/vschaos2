import torch, math
import numpy as np, torch.nn as nn
from .. import DeconvLayer
import vschaos.modules.layers as layers
from typing import Tuple


## Convolutional Blocks for specific applications
# Upsampling / Pooling blocks for progressive GANs

class UpsamplingConvBlock(nn.Module):
    def __init__(self, channels: Tuple[int, int], *args,
                 upsample: int=2, n_convs_per_block: int=2, up_pos:str="first",
                 method="fixed", mode:str="bilinear", **kwargs):
        """
        An upsampling convolutional block, usually used in growing architectures (as StyleGAN).
        Args:
            channels (Tuple[int, int]): in & out channels.
            *args : additional args passed to conv layers during initialization
            upsample (int): upsampling factor (default: 2)
            n_convs_per_block: number of convolutional layers in block (default: 2)
            up_pos (str): position of the upsampling module in the block ("first"|"last"). default : first
            mode (str): upsampling mode. default: bilinear
            **kwargs : additional kwargs passed to conv layers during initialization
        """

        super().__init__()
        modules = []
        self.upsample = self.get_upsample_layer(channels=channels, method=method, upsample=upsample, mode=mode, **kwargs)
        if up_pos == "first":
            modules.append(self.upsample)
        for n in range(n_convs_per_block):
            if n == 0:
                modules.append(layers.DeconvLayer([channels[0], channels[1]], *args, **kwargs))
            else:
                modules.append(layers.DeconvLayer([channels[1], channels[1]], *args, **kwargs))
        if up_pos == "last":
            modules.append(self.upsample)
        self.module_list= nn.ModuleList(modules)

    def get_upsample_layer(self, channels=None, method="fixed", upsample=2, mode="bilinear", **kwargs):
        if method == "fixed":
            layer = nn.Upsample(scale_factor=upsample, mode=mode)
        elif method == "conv":
            assert kwargs.get('dim') is not None
            assert channels is not None
            padding = math.floor(upsample / 2)
            layer = layers.deconv_hash['conv'][kwargs['dim']](channels[0], channels[0], kernel_size=upsample * 2,
                                                             stride=upsample, padding=padding,
                                                             bias=kwargs.get('bias'))
        return layer

    def forward(self, x: torch.Tensor, **kwargs) -> torch.Tensor:
        out = x
        for m in self.module_list:
            if isinstance(m, (layers.ConvLayer, layers.DeconvLayer)):
                out = m(out, **kwargs)
            else:
                out = m(out)
        return out

    def output_shape(self, input_dim: np.ndarray) -> np.ndarray:
        """
        returns the output shape from an input shape.
        Args:
            input_dim: input dimension

        Returns:
            output_dim: output dimension
        """
        for m in self.module_list:
            if isinstance(m, nn.Upsample):
                input_dim = input_dim * m.scale_factor
            else:
                input_dim = m.output_shape(input_dim)
        return input_dim

    def input_shape(self, output_dim: np.ndarray) -> np.ndarray:
        """
        returns the input shape from an output shape.
        Args:
            input_dim: input dimension

        Returns:
            output_dim: output dimension
        """
        for m in reversed(self.module_list):
            if isinstance(m, nn.Upsample):
                input_dim = output_dim / m.scale_factor
            else:
                input_dim = m.input_shape(output_dim)
        return input_dim

    @classmethod
    def get_output_padding(cls, out_shape: np.ndarray, up_pos: str = 'first',
                           upsample: int = 2, **kwargs) -> Tuple[np.ndarray, np.ndarray]:
        """
        returns the output padding needed to get a target output shape.
        Args:
            out_shape (np.ndarray): input dimension
            up_pos (str): upsampling position (first|last, default: first)
            downsample(int): d

        Returns:
            output_padding (tuple): output padding for target shape
            in_shape (int): input shape of module for target shape

        """
        if up_pos == "last":
            out_shape = out_shape / upsample
        output_padding, out_shape  = DeconvLayer.get_output_padding(out_shape, **kwargs)
        if up_pos == "first":
            out_shape = out_shape / upsample
        return output_padding, out_shape

# StyleGAN2-like upsampling 
class ModUpsamplingBlock(UpsamplingConvBlock):
    def __init__(self, channels, *args, conv_class = "mod", n_convs_per_block = 2, **kwargs):
        super(ModUpsamplingBlock, self).__init__(channels, *args, conv_class=conv_class, n_convs_per_block=n_convs_per_block, **kwargs)


class WaveNetBlock(nn.Module):
    default_layer = layers.GatedConvLayer
    def __init__(self, dilation_channels: int=32, residual_channels: int=32, skip_channels: int=32, kernel_size:int =2,
                 layer: type=None, n_convs_per_block: int=9, nnlin: str="Tanh", bias: bool=False,
                 dilation_rate: int=2, snap: str="right", **kwargs) -> None:
        """
        Skip/residual architectures used in auto-regressive models such as WaveNet.

        Args:
            dilation_channels (int): number of channels used in dilated convs (default: 32)
            residual_channels (int): number of channels used in residual convs (default: 32)
            skip_channels (int):  number of channels used in skip connections (default: 32)
            kernel_size (int): kernel size
            layer (type): layer class used (default: layers.GatedConvLayer)
            n_convs_per_block (int): number of convolutional layers per block (default: 9)
            nnlin (str): non-linearity used (default: Tanh)
            bias (bool): has bias (default: False)
            dilation_rate (int): dilation rate (default: 2)
            snap (str): if residual and dilated outputs do not match, defines snap mode (left|right, default: right)
            **kwargs:
        """
        super().__init__()
        self.gated_convs = [None] *  n_convs_per_block
        self.residual_convs = [None] * n_convs_per_block
        self.skip_convs = [None] * n_convs_per_block
        layer = getattr(layers, layer or self.default_layer)
        self.dilation_rate = dilation_rate
        for n in range(n_convs_per_block):
            current_dilation = dilation_rate ** n
            self.gated_convs[n] = layer([residual_channels, dilation_channels], kernel_size=kernel_size, nn_lin=nnlin, dilation = current_dilation, bias=bias, padding=0, dim=1)
            self.residual_convs[n] = nn.Conv1d(dilation_channels, residual_channels, kernel_size = 1, bias=bias, dilation=current_dilation)
            self.skip_convs[n] = nn.Conv1d(dilation_channels, skip_channels, kernel_size = 1, bias = bias, dilation=current_dilation)
        self.gated_convs = nn.ModuleList(self.gated_convs)
        self.residual_convs = nn.ModuleList(self.residual_convs)
        self.skip_convs = nn.ModuleList(self.skip_convs)
        self.snap = snap

    def snap_tensor(self, gated_out, residual_out):
        gated_shape = gated_out.shape[-1]
        if self.snap == "right":
            return residual_out[..., -gated_shape:]
        elif self.snap == "left":
            return residual_out[..., :gated_shape]

    def __call__(self, x, skip_buffer=None, return_skip = True):
        out = x
        for i in range(len(self.gated_convs)):
            gated_out = self.gated_convs[i](out)
            residual_out = self.residual_convs[i](out)
            if skip_buffer is None:
                skip_buffer = self.skip_convs[i](gated_out)
            else:
                self.write_skip_buffer(skip_buffer, self.skip_convs[i](residual_out))
            out = gated_out + self.snap_tensor(gated_out, residual_out)
        if return_skip:
            return out, skip_buffer
        else:
            return out


class DownsamplingConvBlock(nn.Module):
    def __init__(self, channels, *args, downsample=2, pooling="avg", n_convs_per_block=2, up_pos="last", **kwargs):
        """
        An downsampling convolutional block, usually used in growing architectures (as StyleGAN).
        Args:
            channels (Tuple[int, int]): in & out channels.
            *args : additional args passed to conv layers during initialization
            downsample (int): downsampling factor (default: 2)
            n_convs_per_block: number of convolutional layers in block (default: 2)
            up_pos (str): position of the downsampling module in the block ("first"|"last"). default : last
            pooling (str): downsampling mode (avg|max). default: avg
            **kwargs : additional kwargs passed to conv layers during initialization
        """
        super().__init__()
        modules = []
        dim = kwargs.get('dim')
        self.downsample = layers.pooling_hash[pooling][dim](downsample)
        if up_pos == "first":
            modules.append(self.downsample)
        for n in range(n_convs_per_block):
            if n == 0:
                modules.append(layers.ConvLayer([channels[0], channels[1]], *args, **kwargs))
            else:
                modules.append(layers.ConvLayer([channels[1], channels[1]], *args, **kwargs))
        if up_pos == "last":
            modules.append(self.downsample)
        self.module_list= nn.ModuleList(modules)

    def forward(self, x, **kwargs):
        out = x
        for m in self.module_list:
            out = m(out)
        return out

    def output_shape(self, input_dim):
        for m in self.module_list:
            if isinstance(m, (nn.AvgPool1d, nn.AvgPool2d, nn.AvgPool3d, nn.MaxPool1d, nn.MaxPool2d, nn.MaxPool3d)):
                input_dim = input_dim / m.kernel_size
            else:
                input_dim = m.output_shape(input_dim)
        return input_dim

    def input_shape(self, output_dim):
        for m in reversed(self.module_list):
            if isinstance(m, nn.Upsample):
                input_dim = input_dim * m.kernel_size
            else:
                input_dim = m.input_shape(input_dim)
        return input_dim

