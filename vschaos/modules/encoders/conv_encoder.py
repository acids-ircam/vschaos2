from collections import namedtuple
import sys, pdb

sys.path.append('../')
import torch, torch.nn as nn, numpy as np, math
from vschaos.utils import checklist, checktuple, checkdist, checksize, reshape_batch, flatten_batch
from omegaconf import OmegaConf
from vschaos.modules import conv, layers as layers, mlp_dist_hash, conv_dist_hash, Reshape
import vschaos.distributions as dist
from typing import Tuple, Union, Iterable, List


class ConvEncoder(nn.Module):
    Layer = "ConvLayer"
    Flatten = "MLP"

    def __len__(self):
        return len(self.conv_modules) + (self.has_flatten and self.index_flatten)

    def __getitem__(self, item):
        return self.get_submodule(item)

    @property
    def has_flatten(self):
        return self.flatten_module is not None

    def __init__(self, config, init_modules=True):
        """
        Convolutional encoder for auto-encoding architectures. OmegaConfuration may include:
        input_shape (Iterable[int]): input dimensionality
        layer (type): convolutional layer (ConvLayer, GatedConvLayer)
        channels (Iterable[int]): sequence of channels
        kernel_size (int, Iterable[int]): sequence of kernel sizes (default: 7)
        dilation (int, Iterable[int]): sequence of dilations (default: 1)
        stride (int, Interable[int]): sequence of strides (default: 1)
        bias (bool): convolution with bias
        dim (int): input dimensionality (1, 2, 3)
        hidden_dims (int, Iterable[int]): hidden dimensions
        nnlin (str): non-linearity (default : SiLU)
        norm (str): normalization
        target_shape (Iterable[int]): target shape of encoder
        target_dist: (type) target distribution of encoder
        reshape_method (str): how is convolutional output reshaped (default: 'flatten')
        flatten_args (OmegaConf): keyword arguments for flatten module

        Args:
            config (OmegaConf): encoder configuration.
        """
        super(ConvEncoder, self).__init__()
        # convolutional parameters
        self.input_shape = checksize(config.get('input_shape'))
        self.mode = config.get('mode', "forward")
        self.channels = checklist(config.channels)
        self.n_layers = len(self.channels)
        self.kernel_size = checklist(config.get('kernel_size', 7), n=self.n_layers)
        self.dilation = checklist(config.get('dilation', 1), n=self.n_layers)
        self.padding = checklist(config.get('padding'), n=self.n_layers)
        self.dropout = checklist(config.get('dropout'), n=self.n_layers)
        self.stride = checklist(config.get('stride', 1), n=self.n_layers)
        self.dim = config.get('dim', len(config.get('input_shape', [None] * 3)) - 1)
        self.nnlin = checklist(config.get('nnlin'), n=self.n_layers)

        self.Layer = checklist(config.get('layer', self.Layer), n=self.n_layers)
        self.config_flatten = dict(config.get('flatten_args', {}))
        self.flatten_type = getattr(layers, config.get('flatten_module', self.Flatten))
        self.norm = checklist(config.get('norm'), n=self.n_layers)
        self.bias = config.get('bias', True)
        self.block_args = checklist(config.get('block_args', {}), n=self.n_layers)

        # flattening parameters
        self.target_shape = checksize(config.get('target_shape'))
        self.target_dist = config.get('target_dist')
        self.index_flatten = config.get('index_flatten', True)
        self.reshape_method = config.get('reshape_method', "flatten")

        # distribution parameters
        if init_modules:
            self.out_nnlin = config.get('out_nnlin')
            if self.out_nnlin is not None:
                self.out_nnlin = getattr(nn, self.out_nnlin)()
        if self.target_dist:
            self.target_dist = checkdist(self.target_dist)
            if init_modules:
                self.dist_module = mlp_dist_hash[self.target_dist](out_nnlin=self.out_nnlin)
            # self.channels[-1] *= self.dist_module.required_dim_upsampling
        else:
            if init_modules:
                self.dist_module = self.out_nnlin if self.out_nnlin is not None else None

        # init modules
        self.aggregate = config.get('aggregate')
        self.multi_preconv = config.get('multi_preconv', False)
        if init_modules:
            self._init_modules()

    def _init_conv_modules(self):
        modules = []
        preconv_args = {'kernel_size': self.kernel_size[0], 'dilation': self.dilation[0], 'stride': self.stride[0], 'norm': self.norm[0], 
                        'dropout':self.dropout[0], 'nnlin': self.nnlin[0], 'dim': self.dim, **self.block_args[0]}
        if self.multi_preconv:
            Layer = getattr(layers, self.Layer[0])
            self.pre_conv = nn.ModuleList([Layer([self.input_shape[0], c], **preconv_args) for c in self.channels])
        else:
            Layer = getattr(layers, self.Layer[0])
            self.pre_conv = nn.ModuleList([Layer([self.input_shape[0], self.channels[0]], **preconv_args)])
        for n in range(self.n_layers-1):
            Layer = getattr(layers, self.Layer[n+1])
            in_channels, out_channels = self.channels[n], self.channels[n + 1]
            current_layer = Layer([in_channels, out_channels],
                                  kernel_size=self.kernel_size[n+1],
                                  dilation=self.dilation[n+1],
                                  padding=self.padding[n+1],
                                  dim=self.dim,
                                  stride=self.stride[n+1],
                                  norm=self.norm[n+1],
                                  dropout=self.dropout[n+1],
                                  bias=self.bias,
                                  nnlin=self.nnlin[n+1],
                                  **self.block_args[n+1])
            modules.append(current_layer)
        self.conv_modules = nn.ModuleList(modules)

    def _init_flattening_modules(self):
        self.flatten_module = None
        if self.reshape_method in ["flatten", "pgan", "channel"]:
            current_shape = np.array(self.input_shape[1:])
            conv_modules = [self.pre_conv[0]] + list(self.conv_modules)
            for c in conv_modules:
                current_shape = c.output_shape(current_shape)
            target_shape = int(checklist(self.target_shape)[0])
            if self.target_dist == dist.Normal:
                target_shape *= 2
            flatten_shape = self.channels[-1] * int(np.cumprod(current_shape)[-1])
            if self.reshape_method == "flatten":
                self.flatten_module = nn.Sequential(Reshape(flatten_shape, incoming_dim=self.dim + 1),
                                                    self.flatten_type(flatten_shape, target_shape,
                                                                  **self.config_flatten))
            elif self.reshape_method == "pgan":
                flatten_module = []
                for i in range(self.block_args[-1].get('n_convs_per_block', 2) - 1):
                    flatten_module.append(layers.ConvLayer([self.channels[-1], self.channels[-1]],
                                                            kernel_size = self.kernel_size[-1]))
                flatten_module.append(layers.ConvLayer([self.channels[-1], self.channels[-1]],
                                                       kernel_size=current_shape.astype(np.int16).tolist(),
                                                       padding=0))
                flatten_module.append(Reshape(self.channels[-1], incoming_dim=(self.dim+1)))
                flatten_module.append(layers.MLPLayer(self.channels[-1], target_shape, norm=None, nnlin=None))
                self.flatten_module = nn.Sequential(*flatten_module)
        elif self.reshape_method == "reshape":
            self.flatten_module = Reshape(self.channels[-1])

    def _init_modules(self):
        self._init_conv_modules()
        self._init_flattening_modules()

    def forward(self, x: torch.Tensor, transition: Union[float, None] = None):# -> Union[
        #torch.Tensor, dist.Distribution]:
        """
        Encodes incoming tensor.
        Args:
            x (torch.Tensor): data to encode
            return_hidden (bool): return intermediate hidden vectors
            transition (float): transition factor for progressive learning

        Returns:
            y (torch.Tensor or Distribution): encoded data.
        """
        x, batch_shape = flatten_batch(x, dim=-(self.dim+1))
        out = x

        # fill buffers
        if hasattr(self, "pre_conv"):
            out = self.pre_conv[0](out)
        # compute convs
        for i, conv_module in enumerate(self.conv_modules):
            out = conv_module(out)

        if self.reshape_method == "none":
            out = reshape_batch(out, batch_shape, -(self.dim+1))
        elif self.reshape_method == "channel":
            out = self.flatten_module(out)
            out = reshape_batch(out, batch_shape, -(self.dim+1))
        elif self.reshape_method == "flatten":
            out = self.flatten_module(out)
            out = reshape_batch(out, batch_shape, -1)
        if hasattr(self, "dist_module"):
            if self.dist_module is not None:
                out = self.dist_module(out)
        return out

    @torch.jit.ignore
    def __call__(self, x: torch.Tensor, return_hidden=False, transition=None, trace=None, **kwargs) -> Union[
        torch.Tensor, dist.Distribution]:
        """
        Encodes incoming tensor.
        Args:
            x (torch.Tensor): data to encode
            return_hidden (bool): return intermediate hidden vectors
            transition (float): transition factor for progressive learning

        Returns:
            y (torch.Tensor or Distribution): encoded data.
        """
        dim = len(checktuple(self.input_shape)) if self.input_shape is not None else ((self.dim + 1) or len(x.shape) - 1)
        batch_shape = x.shape[:-dim]
        out = x.reshape(-1, *x.shape[-(self.dim + 1):])
        out_orig = out

        # set inputs
        hidden = []
        if hasattr(self, "pre_conv"):
            out = self.pre_conv[0](out)
        for i, conv_module in enumerate(self.conv_modules):
            out = conv_module(out)
            hidden.append(out)

        out = out.view(*batch_shape, *out.shape[1:])
        if hasattr(self, "flatten_module"):
            if self.flatten_module is not None:
                out = self.flatten_module(out)
        hidden.append(out)
        if hasattr(self, "dist_module"):
            if self.dist_module is not None:
                out = self.dist_module(out)
        if trace is not None:
            for i, h in enumerate(hidden):
                trace['layer_%d'%i] = h
        if return_hidden:
            return out, hidden
        else:
            return out
    
    def get_submodule(self, items: Union[int, List[int], range]) -> nn.Module:
        if isinstance(items, slice):
            items = list(range(len(self)))[items]
        elif isinstance(items, int):
            if items < 0:
                items = len(self) + items
            items = [items]
        if len(items) == 0:
            raise IndexError("cannot retrieve %s of ConvEncoder")
        config = OmegaConf.create()

        if 0 in items:
            config.input_shape = checklist(self.input_shape)
        if len(self) - 1 in items:
            config.target_shape = checklist(self.target_shape)

        # set convolution parameters
        config.dim = self.dim
        offset = None
        if len(self) - 1 in items and (self.has_flatten and self.index_flatten):
            offset = -1 * (self.has_flatten)
            config.channels = [self.channels[i] for i in items]
        else:
            config.channels = [self.channels[i] for i in items] + [self.channels[items[-1] + 1]]
        config.n_layers = len(items)
        config.kernel_size = [self.kernel_size[i] for i in items[:offset]]
        config.dilation = [self.dilation[i] for i in items[:offset]]
        config.padding = [self.padding[i] for i in items[:offset]]
        config.dropout = [self.dropout[i] for i in items[:offset]]
        config.stride = [self.stride[i] for i in items[:offset]]
        config.nnlin = [self.nnlin[i] for i in items[:offset]]
        config.block_args = [self.block_args[i] for i in items[:offset]]
        config.norm = [self.norm[i] for i in items[:offset]]
        config.mode = self.mode
        config.bias = self.bias
        config.Layer = self.Layer
        module = type(self)(config, init_modules=False)

        conv_modules = []
        pre_convs = []
        for i in items:
            if i == 0:
                module.dist_module = self.dist_module
                if self.mode in ["forward"]:
                    module.pre_conv = self.pre_conv
            if i != len(self) - 1:
                conv_modules.append(self.conv_modules[i])
                if self.mode in ["skip", "residual", "forward+"]:
                    pre_convs.append(self.pre_conv[i])
            else:
                if self.has_flatten:
                    module.flatten_type = self.flatten_type
                    module.flatten_module = self.flatten_module
                if self.has_flatten and (not self.index_flatten):
                    conv_modules.append(self.conv_modules[i])
                if hasattr(self, "dist_module"):
                    module.dist_module = self.dist_module
                if hasattr(self, "out_nnlin"):
                    module.out_nnlin = self.out_nnlin
                if self.mode == "forward":
                    pre_convs.append(self.pre_conv)
                else:
                    pre_convs.append(self.pre_conv[i])
        module.conv_modules = nn.ModuleList(conv_modules)
        if self.mode in ["skip", "residual", "forward+"]:
            module.pre_conv = nn.ModuleList(pre_convs)
        return module

# old code from encoders.py 
# have to reimplement Residual and Skip encoders


"""
class ConvEncoder(nn.Module):
    Layer = "ConvLayer"
    Flatten = "MLP"
    available_modes = ['forward', 'forward+', 'skip', 'residual']

    def __len__(self):
        return len(self.conv_modules) + (self.has_flatten and self.index_flatten)

    def __getitem__(self, item):
        return self.get_submodule(item)

    @property
    def has_flatten(self):
        return self.flatten_module is not None

    def __init__(self, config, init_modules=True):
        super(ConvEncoder, self).__init__()
        # convolutional parameters
        self.input_shape = config.get('input_shape')
        self.mode = config.get('mode', "forward")
        self.channels = checklist(config.channels)
        self.n_layers = len(self.channels) - 1
        self.kernel_size = checklist(config.get('kernel_size', 7), n=self.n_layers)
        self.dilation = checklist(config.get('dilation', 1), n=self.n_layers)
        self.padding = checklist(config.get('padding'), n=self.n_layers)
        self.dropout = checklist(config.get('dropout'), n=self.n_layers)
        self.stride = checklist(config.get('stride', 1), n=self.n_layers)
        self.dim = config.get('dim', len(config.get('input_shape', [None] * 3)) - 1)
        self.nnlin = checklist(config.get('nnlin'), n=self.n_layers)

        self.Layer = checklist(config.get('layer', self.Layer), n=self.n_layers)
        self.config_flatten = dict(config.get('flatten_args', {}))
        self.flatten_type = getattr(layers, config.get('flatten_module', self.Flatten))
        self.norm = checklist(config.get('norm'), n=self.n_layers)
        self.bias = config.get('bias', True)
        self.block_args = checklist(config.get('block_args', {}), n=self.n_layers)

        # flattening parameters
        self.target_shape = config.get('target_shape')
        self.target_dist = config.get('target_dist')
        self.index_flatten = config.get('index_flatten', True)
        self.reshape_method = config.get('reshape_method', "flatten")

        # distribution parameters
        if init_modules:
            self.out_nnlin = config.get('out_nnlin')
            if self.out_nnlin is not None:
                self.out_nnlin = getattr(nn, self.out_nnlin)()
        if self.target_dist:
            self.target_dist = checkdist(self.target_dist)
            if init_modules:
                self.dist_module = mlp_dist_hash[self.target_dist](out_nnlin=self.out_nnlin)
            self.channels[-1] *= self.dist_module.required_dim_upsampling
        else:
            if init_modules:
                self.dist_module = self.out_nnlin if self.out_nnlin is not None else None

        # init modules
        self.aggregate = config.get('aggregate')
        if init_modules:
            self._init_modules()

    def _init_conv_modules(self):
        modules = []
        if self.mode in ["forward"]:
            self.pre_conv = nn.ModuleList([layers.conv_hash['conv'][self.dim](self.input_shape[0], self.channels[0], 1)])
        elif self.mode in ["forward+", "residual", "skip"]:
            self.pre_conv = nn.ModuleList(
                [layers.conv_hash['conv'][self.dim](self.input_shape[0], c, 1) for c in self.channels])
        for n in range(self.n_layers):
            Layer = getattr(layers, self.Layer[n])
            if n > 0 and self.mode == "skip":
                in_channels, out_channels = self.channels[n], self.channels[n + 1]
            else:
                in_channels, out_channels = self.channels[n], self.channels[n + 1]
            current_layer = Layer([in_channels, out_channels],
                                  kernel_size=self.kernel_size[n],
                                  dilation=self.dilation[n],
                                  padding=self.padding[n],
                                  dim=self.dim,
                                  stride=self.stride[n],
                                  norm=self.norm[n],
                                  dropout=self.dropout[n],
                                  bias=self.bias,
                                  nnlin=self.nnlin[n],
                                  **self.block_args[n])
            modules.append(current_layer)
        self.conv_modules = nn.ModuleList(modules)

    def _init_flattening_modules(self):
        self.flatten_module = None

        if self.reshape_method in ["flatten", "pgan", "channel"]:
            current_shape = np.array(self.input_shape[1:])
            for c in self.conv_modules:
                current_shape = c.output_shape(current_shape)
            target_shape = int(self.target_shape)
            if self.target_dist == dist.Normal:
                target_shape *= 2
            flatten_shape = self.channels[-1] * int(np.cumprod(current_shape)[-1])
            if self.reshape_method == "flatten":
                self.flatten_module = nn.Sequential(Reshape(flatten_shape, incoming_dim=self.dim + 1),
                                                    self.flatten_type(flatten_shape, target_shape,
                                                                  **self.config_flatten))
            elif self.reshape_method == "pgan":
                flatten_module = []
                for i in range(self.block_args[-1].get('n_convs_per_block', 2) - 1):
                    flatten_module.append(layers.ConvLayer([self.channels[-1], self.channels[-1]],
                                                            kernel_size = self.kernel_size[-1]))
                flatten_module.append(layers.ConvLayer([self.channels[-1], self.channels[-1]],
                                                       kernel_size=current_shape.astype(np.int16).tolist(),
                                                       padding=0))
                flatten_module.append(Reshape(self.channels[-1], incoming_dim=(self.dim+1)))
                flatten_module.append(layers.MLPLayer(self.channels[-1], target_shape, norm=None, nnlin=None))
                self.flatten_module = nn.Sequential(*flatten_module)
        elif self.reshape_method == "reshape":
            self.flatten_module = Reshape(self.channels[-1])

    def _init_modules(self):
        self._init_conv_modules()
        self._init_flattening_modules()

    def forward(self, x: torch.Tensor, transition: Union[float, None] = None) -> Union[
        torch.Tensor, dist.Distribution]:
        x, batch_shape = flatten_batch(x, dim=-(self.dim+1))
        out = x
        out_orig = out

        # fill buffers
        buffer = out
        # if self.mode == "skip":
        #     buffer = out
        if hasattr(self, "pre_conv"):
            out = self.pre_conv[0](out)
        # if self.mode == "residual":
        #     buffer = out
        # compute convs
        for i, conv_module in enumerate(self.conv_modules):
            if self.mode in ['skip']:
                if i > 0:
                    if hasattr(conv_module, "downsample"):
                        buffer = self.conv_modules[i - 1].downsample(buffer)
                    out = out + self.pre_conv[i](buffer)
            out = conv_module(out)
            if i == 0 and transition:
                if hasattr(conv_module, "downsample"):
                    out_orig = conv_module.downsample(out_orig)
                out = transition * out + (1 - transition) * self.pre_conv[i+1](out_orig)

            if self.mode in ['residual']:
                if hasattr(conv_module, "downsample"):
                    buffer = self.conv_modules[i - 1].downsample(buffer)
                buffer = out + buffer
                out = buffer

        out = out.view(*batch_shape, *out.shape[1:])
        if hasattr(self, "flatten_module"):
            if self.flatten_module is not None:
                out = self.flatten_module(out)
        if hasattr(self, "dist_module"):
            if self.dist_module is not None:
                out = self.dist_module(out)
        return out

    @torch.jit.ignore
    def __call__(self, x: torch.Tensor, return_hidden=False, transition=None, trace=None, **kwargs) -> Union[
        torch.Tensor, dist.Distribution]:
        dim = len(checktuple(self.input_shape)) if self.input_shape is not None else ((self.dim + 1) or len(x.shape) - 1)
        batch_shape = x.shape[:-dim]
        out = x.reshape(-1, *x.shape[-(self.dim + 1):])
        out_orig = out

        # set inputs
        hidden = []
        # fill buffers
        if self.mode == "skip":
            buffer = out
        if hasattr(self, "pre_conv"):
            pre_conv = self.pre_conv if not isinstance(self.pre_conv, nn.ModuleList) else self.pre_conv[0]
            out = pre_conv(out)
        if self.mode == "residual":
            buffer = out
        # compute convs
        for i, conv_module in enumerate(self.conv_modules):
            if self.mode in ['skip']:
                if i > 0:
                    if hasattr(conv_module, "downsample"):
                        buffer = self.conv_modules[i - 1].downsample(buffer)
                    out = out + self.pre_conv[i](buffer)
            out = conv_module(out)
            if i == 0 and transition:
                if hasattr(conv_module, "downsample"):
                    out_orig = conv_module.downsample(out_orig)
                out = transition * out + (1 - transition) * self.pre_conv[i+1](out_orig)

            if self.mode in ['residual']:
                if hasattr(conv_module, "downsample"):
                    buffer = self.conv_modules[i - 1].downsample(buffer)
                buffer = out + buffer
                out = buffer
            hidden.append(out)

        out = out.view(*batch_shape, *out.shape[1:])
        if hasattr(self, "flatten_module"):
            if self.flatten_module is not None:
                out = self.flatten_module(out)
        hidden.append(out)
        if hasattr(self, "dist_module"):
            if self.dist_module is not None:
                out = self.dist_module(out)

        if trace is not None:
            for i, h in enumerate(hidden):
                trace['layer_%d'%i] = h

        if return_hidden:
            return out, hidden
        else:
            return out

    def get_submodule(self, items: Union[int, List[int], range]) -> nn.Module:
        if isinstance(items, slice):
            items = list(range(len(self)))[items]
        elif isinstance(items, int):
            if items < 0:
                items = len(self) + items
            items = [items]
        if len(items) == 0:
            raise IndexError("cannot retrieve %s of ConvEncoder")
        config = OmegaConf.create()

        if 0 in items:
            config.input_shape = self.input_shape
        if len(self) - 1 in items:
            config.target_shape = self.target_shape

        # set convolution parameters
        config.dim = self.dim
        offset = None
        if len(self) - 1 in items and (self.has_flatten and self.index_flatten):
            offset = -1 * (self.has_flatten)
            config.channels = [self.channels[i] for i in items]
        else:
            config.channels = [self.channels[i] for i in items] + [self.channels[items[-1] + 1]]
        config.n_layers = len(items)
        config.kernel_size = [self.kernel_size[i] for i in items[:offset]]
        config.dilation = [self.dilation[i] for i in items[:offset]]
        config.padding = [self.padding[i] for i in items[:offset]]
        config.dropout = [self.dropout[i] for i in items[:offset]]
        config.stride = [self.stride[i] for i in items[:offset]]
        config.nnlin = [self.nnlin[i] for i in items[:offset]]
        config.block_args = [self.block_args[i] for i in items[:offset]]
        config.norm = [self.norm[i] for i in items[:offset]]
        config.mode = self.mode
        config.bias = self.bias
        config.Layer = self.Layer
        module = type(self)(config, init_modules=False)

        conv_modules = []
        pre_convs = []
        for i in items:
            if i == 0:
                module.dist_module = self.dist_module
                if self.mode in ["forward"]:
                    module.pre_conv = self.pre_conv
            if i != len(self) - 1:
                conv_modules.append(self.conv_modules[i])
                if self.mode in ["skip", "residual", "forward+"]:
                    pre_convs.append(self.pre_conv[i])
            else:
                if self.has_flatten:
                    module.flatten_type = self.flatten_type
                    module.flatten_module = self.flatten_module
                if self.has_flatten and (not self.index_flatten):
                    conv_modules.append(self.conv_modules[i])
                if hasattr(self, "dist_module"):
                    module.dist_module = self.dist_module
                if hasattr(self, "out_nnlin"):
                    module.out_nnlin = self.out_nnlin
                if self.mode == "forward":
                    pre_convs.append(self.pre_conv)
                else:
                    pre_convs.append(self.pre_conv[i])
        module.conv_modules = nn.ModuleList(conv_modules)
        if self.mode in ["skip", "residual", "forward+"]:
            module.pre_conv = nn.ModuleList(pre_convs)
        return module
"""