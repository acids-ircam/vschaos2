from collections import namedtuple
import sys, pdb

sys.path.append('../')
import torch, torch.nn as nn, numpy as np, math
from vschaos.utils import checklist, checksize, checkdist, reshape_batch, flatten_batch
from omegaconf import OmegaConf
from vschaos.modules import conv, layers as layers, mlp_dist_hash, conv_dist_hash, Reshape
import vschaos.distributions as dist
from typing import Tuple, Union, Iterable, List


class DeconvEncoder(nn.Module):
    Layer = "DeconvLayer"
    Flatten = "MLP"
    available_modes = ['forward', 'forward+', 'residual', 'skip', 'parallel']

    def __init__(self, config: OmegaConf, init_modules=True):
        """
        Convolutional encoder for auto-encoding architectures. OmegaConfuration may include:
        input_shape (Iterable[int]): input dimensionality
        layer (type): convolutional layer (ConvLayer, GatedConvLayer)
        channels (Iterable[int]): sequence of channels
        kernel_size (int, Iterable[int]): sequence of kernel sizes (default: 7)
        dilation (int, Iterable[int]): sequence of dilations (default: 1)
        stride (int, Interable[int]): sequence of strides (default: 1)
        dim (int): input dimensionality (1, 2, 3)
        hidden_dims (int, Iterable[int]): hidden dimensions
        nnlin (str): non-linearity (default : SiLU)
        norm (str): normalization
        bias (bool): convolutional bias
        target_shape (Iterable[int]): target shape of encoder
        target_dist: (type) target distribution of encoder
        reshape_method (str): how is convolutional output reshaped (flatten or reshape, default: 'flatten')
        flatten_args (OmegaConf): keyword arguments for flatten module

        Args:
            config (OmegaConf): decoder configuration.
            encoder (nn.Module): corresponding encoder
        """
        super(DeconvEncoder, self).__init__()
        # access to encoder may be useful for skip-connection / pooling operations
        # set dimensionality parameters
        self.input_shape = checksize(config.get('input_shape'))
        self.target_shape = checksize(config.get('target_shape'))
        self.out_channels = self.target_shape[0] if self.target_shape else config.get('out_channels')

        # set convolution parameters
        self.dim = config.get('dim') or len(self.target_shape or [None] * 3) - 1
        self.channels = list(config.get('channels'))
        self.n_layers = len(self.channels) - 1
        self.kernel_size = list(checklist(config.get('kernel_size', 7), n=self.n_layers))
        self.dilation = list(checklist(config.get('dilation', 1), n=self.n_layers))
        self.padding = list(checklist(config.get('padding'), n=self.n_layers))
        self.dropout = list(checklist(config.get('dropout'), n=self.n_layers))
        self.stride = list(checklist(config.get('stride', 1), n=self.n_layers))
        self.output_padding = [np.zeros(self.dim)] * self.n_layers
        self.nnlin = list(checklist(config.get('nnlin', layers.DEFAULT_NNLIN), n=self.n_layers))
        self.mode = config.get('mode', 'forward')
        assert self.mode in self.available_modes

        self.norm = list(checklist(config.get('norm'), n=self.n_layers))
        self.bias = config.get('bias', True)
        self.Layer = checklist(config.get('layer', self.Layer), n=self.n_layers)
        self.block_args = checklist(config.get('block_args', {}), n=self.n_layers)

        # output parameters
        self.target_dist = config.get('target_dist')
        self.out_nnlin = config.get('out_nnlin')
        if self.out_nnlin is not None:
            self.out_nnlin = getattr(nn, self.out_nnlin)()
        if self.target_dist:
            self.target_dist = checkdist(self.target_dist)
            if init_modules:
                self.dist_module = conv_dist_hash[self.target_dist](out_nnlin=self.out_nnlin, dim=self.dim)
        else:
            if init_modules:
                self.dist_module = self.out_nnlin if self.out_nnlin is not None else None

        # flattening parameters
        self.reshape_method = config.get('reshape_method') or "flatten"
        self.config_flatten = dict(config.get('flatten_args', {}))
        self.flatten_type = getattr(layers, config.get('flatten_module') or self.Flatten)
        self.index_flatten = config.get('index_flatten', True)

        self.aggregate = config.get('aggregate')
        # init modules
        if init_modules:
            self._init_modules()

    def __len__(self):
        return len(self.conv_modules) + (self.has_flatten and self.index_flatten)

    @property
    def has_flatten(self):
        return self.flatten_module is not None

    def __getitem__(self, item):
        return self.get_submodule(item)


    def get_channels_from_dist(self, out_channels: int, target_dist: dist.Distribution = None):
        """returns channels from output distribution."""
        target_dist = target_dist or self.target_dist
        if hasattr(target_dist, "get_nchannels_params"):
            return target_dist.get_nchannels_params()
        elif target_dist == dist.Normal:
            return out_channels * 2
        else:
            return out_channels

    def _init_modules(self):
        # init convolutional modules
        self._init_conv_modules()
        self._init_unfold_modules()
        self._init_final_convs()

    def _init_conv_modules(self):
        modules = []
        Layers = [getattr(layers, l) for l in self.Layer]
        # retrieve output paddings
        if self.target_shape is not None:
            current_shape = np.array(self.target_shape[1:])
            output_padding = [None] * self.n_layers
            for n in reversed(range(self.n_layers)):
                output_padding[n], current_shape = Layers[n].get_output_padding(current_shape,
                                                                                kernel_size=self.kernel_size[n],
                                                                                padding=self.padding[n],
                                                                                dilation=self.dilation[n],
                                                                                stride=self.stride[n],
                                                                                **self.block_args[n])
                if len(output_padding[n]) == 0:
                    output_padding[n] = None
                else:
                    output_padding[n] = tuple(output_padding[n].astype(np.int).tolist())
            self.output_padding = output_padding
        else:
            output_padding = self.output_padding

        for n in range(self.n_layers):
            current_layer = Layers[n]([self.channels[n], self.channels[n + 1]],
                                      kernel_size=self.kernel_size[n],
                                      dilation=self.dilation[n],
                                      padding=self.padding[n],
                                      dropout=self.dropout[n],
                                      stride=self.stride[n],
                                      norm=self.norm[n],
                                      dim=self.dim,
                                      bias=self.bias,
                                      nnlin=self.nnlin[n] if n < self.n_layers else None,
                                      output_padding=output_padding[n],
                                      **self.block_args[n])
            modules.append(current_layer)
        self.conv_modules = nn.ModuleList(modules)

    def _init_unfold_modules(self):
        # init flattening modules
        if self.target_shape is not None:
            # retrieve output paddings
            current_shape = np.array(self.target_shape[1:])
            Layers = [getattr(layers, l) for l in self.Layer]
            for n in reversed(range(self.n_layers)):
                _, current_shape = Layers[n].get_output_padding(current_shape, kernel_size=self.kernel_size[n],
                                                                padding=self.padding[n], dilation=self.dilation[n],
                                                                stride=self.stride[n],
                                                                **self.block_args[n])
        else:
            if self.input_shape is None:
                if self.reshape_method != "none":
                    print('[Warning] could not create flattening module, but reshape_method=%s"%self.reshape_method')
                return
        self.flatten_module = None
        if sum([f % 1.0 for f in current_shape]) > 0:
            print('[Warning] final shape for DeconvEncoder module is non-integer')
        input_shape = (self.channels[0], *([math.ceil(i) for i in current_shape]))
        final_shape = tuple(current_shape.tolist())
        if self.reshape_method == "flatten":
            assert self.target_shape is not None, "target_shape is required when reshape_method == flatten"
            assert self.input_shape, "flattening modules needs the input dimensionality."
            flatten_module = self.flatten_type(self.input_shape, int(np.cumprod(input_shape)[-1]),
                                               **self.config_flatten)
            reshape_module = Reshape(self.channels[0], *final_shape, incoming_dim=1)
            self.flatten_module = nn.Sequential(flatten_module, reshape_module)
        elif self.reshape_method == "channel":
            kernel_size = np.array(input_shape[1:])
            padding = kernel_size - 1
            kernel_size = [int(t) for t in kernel_size]
            padding = [int(t) for t in padding] 
            self.flatten_module = layers.conv_hash['conv'][self.dim](self.input_shape[0], self.channels[0],
                                                                tuple(kernel_size), padding=tuple(padding))
            self.input_shape = (self.input_shape[0], *(1,) * len(final_shape))
        elif self.reshape_method == "pgan":
            kernel_size = np.array(input_shape[1:])
            padding = kernel_size - 1
            flatten_module = [layers.conv_hash['conv'][self.dim](self.input_shape[0], self.channels[0],
                                                                tuple(kernel_size), padding=tuple(padding))]
            for i in range(self.block_args[0].get('n_convs_per_block', 2) - 1):
                flatten_module.append(layers.DeconvLayer([self.channels[0], self.channels[0]],
                                                         dim = self.dim,
                                                         kernel_size=self.kernel_size[0],
                                                         bias=self.bias))
            #reshape_module = Reshape(self.channels[0], *final_shape, incoming_dim=self.dim + 1)
            self.flatten_module = nn.Sequential(*flatten_module)
            self.input_shape = (self.input_shape[0], *(1,) * len(final_shape))
        elif self.reshape_method == "none":
            if self.input_shape is None:
                self.input_shape = [self.channels[0]] + [int(f) for f in final_shape]
            else:
                assert self.input_shape == final_shape, "got input_shape == %s, but input shape for output shape %s with current architecture is : %s"%(self.input_shape, self.target_shape, final_shape)
            self.index_flatten = False
        else:
            raise ValueError("got reshape_method=%s"%self.reshape_method)

        if self.input_shape is None:
            self.input_shape = input_shape

    def _init_final_convs(self):
        out_channels = self.out_channels
        # set ouput channels according to distribution
        if self.dist_module is not None:
            if hasattr(self.dist_module, "required_channel_upsampling"):
                out_channels *= self.dist_module.required_channel_upsampling

        if self.mode in ["forward"]:
            if len(self.kernel_size) == len(self.channels):
                self.final_conv = layers.conv_hash['conv'][self.dim](self.channels[-1], out_channels,
                                                                     self.kernel_size[-1],
                                                                     padding=int(np.floor(self.kernel_size[-1] / 2)))
            else:
                self.final_conv = layers.conv_hash['conv'][self.dim](self.channels[-1], out_channels, 1)
        else:
            final_convs = []
            # if module has a flatten layer, also create a final conv for this layers
            if (self.flatten_module is not None) and self.index_flatten:
                final_convs.append(layers.conv_hash['conv'][self.dim](self.channels[0], out_channels, 1))
            # create a final conv for every layer (generalization of RGB modules in PGAN)
            for n in range(1, len(self.channels)):
                final_convs.append(layers.conv_hash['conv'][self.dim](self.channels[n], out_channels, 1))
            self.final_conv = nn.ModuleList(final_convs)

    @torch.jit.ignore
    def __call__(self, x: torch.Tensor, mod=None, use_final_conv=True, transition=None, trace=None, **kwargs) -> Union[
        torch.Tensor, dist.Distribution]:
        """
        decodes an incoming tensor.
        Args:
            x (torch.Tensor): incoming tensor
            seq_shape (int, optional): number of decoded elements (if recurrent flattening module)

        Returns:
            out (torch.Tensor): decoded output
        """
        out = x
        if self.reshape_method == "flatten":
            out, batch_size = flatten_batch(out, dim=-1)
        else:
            out, batch_size = flatten_batch(out, dim=-(self.dim+1))
        if self.flatten_module is not None:
            out = self.flatten_module(out)

        # process convolutions
        hidden = []
        for i, conv_module in enumerate(self.conv_modules):
            # keep last output for transition
            # perform conv
            last_out = out
            if mod is not None:
                if isinstance(mod, (list, tuple)):
                    out = conv_module(out, mod=mod[i])
                else:
                    out = conv_module(out, mod=mod)
            else:
                out = conv_module(out)
            # add to previous outputs for residual connections
            hidden.append(out)

        # if transitioning, past previous output in last layer upsampling
        if transition and isinstance(self.conv_modules, nn.ModuleList):
            if hasattr(self.conv_modules[-1], "upsample"):
                last_out = self.conv_modules[-1].upsample(last_out)

        # process output
        if hasattr(self, "final_conv") and use_final_conv:
            final_conv = self.final_conv if not isinstance(self.final_conv, nn.ModuleList) else self.final_conv[-1]
            out = final_conv(out)
            if transition and isinstance(self.final_conv, nn.ModuleList):
                if len(self.final_conv) >= 2:
                    out = (1 - transition) * self.final_conv[-2](last_out) + transition * out

        if trace is not None:
            for i, h in enumerate(hidden):
                trace['layer_%d'%i] = h

        out = reshape_batch(out, batch_size, dim=-(self.dim+1))
        if hasattr(self, "dist_module"):
            if self.dist_module is not None:
                out = self.dist_module(out)

        return out

    def forward(self, x: torch.Tensor, transition:Union[None, float] = None):# -> Union[
        #torch.Tensor, dist.Distribution]:
        """
        decodes an incoming tensor.
        Args:
            x (torch.Tensor): incoming tensor
            seq_shape (int, optional): number of decoded elements (if recurrent flattening module)

        Returns:
            out (torch.Tensor): decoded output
        """
        out = x
        if self.reshape_method == "flatten":
            out, batch_size = flatten_batch(out, dim=-1)
        else:
            out, batch_size = flatten_batch(out, dim=-(self.dim+1))
        if self.flatten_module is not None:
            out = self.flatten_module(out)

        # process convolutions
        hidden = []
        for i, conv_module in enumerate(self.conv_modules):
            last_out = out if self.mode == "skip" else out
            out = conv_module(out)
            hidden.append(out)

        # if transitioning, past previous output in last layer upsampling
        if (transition is not None) and isinstance(self.conv_modules, nn.ModuleList):
            if hasattr(self.conv_modules[-1], "upsample"):
                last_out = self.conv_modules[-1].upsample(last_out)

        # process output
        if hasattr(self, "final_conv"):
            final_conv = self.final_conv if not isinstance(self.final_conv, nn.ModuleList) else self.final_conv[-1]
            out = final_conv(out)
            if (transition is not None) and isinstance(self.final_conv, nn.ModuleList):
                if len(self.final_conv) >= 2:
                    out = (1 - transition) * self.final_conv[-2](last_out) + transition * out

        out = reshape_batch(out, batch_size, dim=-(self.dim+1))
        if hasattr(self, "dist_module"):
            if self.dist_module is not None:
                out = self.dist_module(out)

        return out
    

    def get_submodule(self, items: Union[int, List[int], range]) -> nn.Module:
        if isinstance(items, slice):
            items = list(range(len(self)))[items]
        elif isinstance(items, int):
            if items < 0:
                items = len(self) + items
            items = [items]
        if len(items) == 0:
            raise IndexError("cannot retrieve %s of ConvDecoder")
        config = OmegaConf.create()

        if 0 in items:
            config.input_shape = self.input_shape
        if len(self.conv_modules) - 1 in items:
            config.target_shape = checklist(self.target_shape)
            config.out_channels = self.out_channels

        # set convolution parameters
        config.dim = self.dim
        offset = 0
        if 0 in items:
            config.channels = [self.channels[i] for i in items]
            offset += (self.has_flatten or self.index_flatten)
        else:
            config.channels = [self.channels[i] for i in items] + [self.channels[items[0] - 1]]
        config.out_channels = self.out_channels
        config.n_layers = len(items)
        config.kernel_size = [self.kernel_size[i - 1] for i in items[offset:]]
        config.dilation = [self.dilation[i - 1] for i in items[offset:]]
        config.padding = [self.padding[i - 1] for i in items[offset:]]
        config.dropout = [self.dropout[i - 1] for i in items[offset:]]
        config.stride = [self.stride[i - 1] for i in items[offset:]]
        config.output_padding = [self.output_padding[i - 1] for i in items[offset:]]
        config.nnlin = [self.nnlin[i - 1] for i in items[offset:]]
        config.norm = [self.norm[i - 1] for i in items[offset:]]
        config.block_args = [self.block_args[i - 1] for i in items[offset:]]
        config.bias = self.bias
        config.mode = self.mode
        config.Layer = self.Layer
        module = type(self)(config, init_modules=False)
        module.flatten_type = None
        module.flatten_module = None

        conv_modules = []
        final_convs = []
        if self.mode in ["skip"]:
            if not 0 in items:
                final_convs.append(self.final_conv[items[0] - (self.has_flatten or self.index_flatten)])
        elif self.mode in ["residual"]:
            final_convs.append(self.final_conv[items[0]])
        for i in items:
            if i == 0:
                module.reshape_method = self.reshape_method
                module.flatten_type = self.flatten_type
                module.flatten_module = self.flatten_module
                if not (self.has_flatten or self.index_flatten):
                    conv_modules.append(self.conv_modules[i])
            else:
                conv_modules.append(self.conv_modules[i - (self.has_flatten or self.index_flatten)])
            if self.mode in ["skip", "forward+"]:
                final_convs.append(self.final_conv[i])
            if i == len(self) - 1:
                if self.mode in ["forward"]:
                    module.final_conv = self.final_conv
                if hasattr(self, "dist_module") and self.mode in ['forward']:
                    module.dist_module = self.dist_module

        module.conv_modules = nn.ModuleList(conv_modules)
        if self.mode in ["skip", "forward+", "residual"]:
            # final_convs.append(self.final_conv[i+1])
            module.final_conv = nn.ModuleList(final_convs)
            if hasattr(self, 'dist_module'):
                module.dist_module = self.dist_module
        return module


"""
class DeconvEncoder(nn.Module):
    Layer = "DeconvLayer"
    Flatten = "MLP"
    available_modes = ['forward', 'forward+', 'residual', 'skip', 'parallel']

    def __init__(self, config: OmegaConf, init_modules=True):
        super(DeconvEncoder, self).__init__()
        # access to encoder may be useful for skip-connection / pooling operations
        # set dimensionality parameters
        self.input_shape = checktuple(config.get('input_shape')) if config.get('input_shape') else None
        self.target_shape = config.get('target_shape')
        self.out_channels = self.target_shape[0] if self.target_shape else config.get('out_channels')

        # set convolution parameters
        self.dim = config.get('dim') or len(self.target_shape or [None] * 3) - 1
        self.channels = list(reversed(config.get('channels')))
        self.n_layers = len(self.channels) - 1
        self.kernel_size = list(reversed(checklist(config.get('kernel_size', 7), n=self.n_layers)))
        self.dilation = list(reversed(checklist(config.get('dilation', 1), n=self.n_layers)))
        self.padding = list(reversed(checklist(config.get('padding'), n=self.n_layers)))
        self.dropout = list(reversed(checklist(config.get('dropout'), n=self.n_layers)))
        self.stride = list(reversed(checklist(config.get('stride', 1), n=self.n_layers)))
        self.output_padding = [np.zeros(self.dim)] * self.n_layers
        self.nnlin = list(reversed(checklist(config.get('nnlin', layers.DEFAULT_NNLIN), n=self.n_layers)))
        self.mode = config.get('mode', 'forward')
        assert self.mode in self.available_modes

        self.norm = list(reversed(checklist(config.get('norm'), n=self.n_layers)))
        self.bias = config.get('bias', True)
        self.Layer = checklist(config.get('layer', self.Layer), n=self.n_layers)
        self.block_args = checklist(config.get('block_args', {}), n=self.n_layers)

        # output parameters
        self.target_dist = config.get('target_dist')
        self.out_nnlin = config.get('out_nnlin')
        if self.out_nnlin is not None:
            self.out_nnlin = getattr(nn, self.out_nnlin)()
        if self.target_dist:
            self.target_dist = checkdist(self.target_dist)
            if init_modules:
                self.dist_module = conv_dist_hash[self.target_dist](out_nnlin=self.out_nnlin, dim=self.dim)
        else:
            if init_modules:
                self.dist_module = self.out_nnlin if self.out_nnlin is not None else None

        # flattening parameters
        self.reshape_method = config.get('reshape_method') or "flatten"
        self.config_flatten = dict(config.get('flatten_args', {}))
        self.flatten_type = getattr(layers, config.get('flatten_module') or self.Flatten)
        self.index_flatten = config.get('index_flatten', True)

        self.aggregate = config.get('aggregate')
        # init modules
        if init_modules:
            self._init_modules()

    def __len__(self):
        return len(self.conv_modules) + (self.has_flatten and self.index_flatten)

    @property
    def has_flatten(self):
        return self.flatten_module is not None

    def __getitem__(self, item):
        return self.get_submodule(item)


    def get_channels_from_dist(self, out_channels: int, target_dist: dist.Distribution = None):
        target_dist = target_dist or self.target_dist
        if hasattr(target_dist, "get_nchannels_params"):
            return target_dist.get_nchannels_params()
        elif target_dist == dist.Normal:
            return out_channels * 2
        else:
            return out_channels

    def _init_modules(self):
        # init convolutional modules
        self._init_conv_modules()
        self._init_unfold_modules()
        self._init_final_convs()

    def _init_conv_modules(self):
        modules = []
        Layers = [getattr(layers, l) for l in self.Layer]
        if self.target_shape is not None:
            # retrieve output paddings
            current_shape = np.array(self.target_shape[1:])
            output_padding = [None] * self.n_layers
            for n in reversed(range(self.n_layers)):
                output_padding[n], current_shape = Layers[n].get_output_padding(current_shape,
                                                                                kernel_size=self.kernel_size[n],
                                                                                padding=self.padding[n],
                                                                                dilation=self.dilation[n],
                                                                                stride=self.stride[n],
                                                                                **self.block_args[n])
                output_padding[n] = tuple(output_padding[n].astype(np.int).tolist())
            self.output_padding = output_padding
        else:
            output_padding = self.output_padding

        for n in range(self.n_layers):
            current_layer = Layers[n]([self.channels[n], self.channels[n + 1]],
                                      kernel_size=self.kernel_size[n],
                                      dilation=self.dilation[n],
                                      padding=self.padding[n],
                                      dropout=self.dropout[n],
                                      stride=self.stride[n],
                                      norm=self.norm[n],
                                      dim=self.dim,
                                      bias=self.bias,
                                      nnlin=self.nnlin[n] if n < self.n_layers else None,
                                      output_padding=output_padding[n],
                                      **self.block_args[n])
            modules.append(current_layer)
        self.conv_modules = nn.ModuleList(modules)



    def _init_unfold_modules(self):
        # init flattening modules
        if self.target_shape is not None:
            # retrieve output paddings
            current_shape = np.array(self.target_shape[1:])
            Layers = [getattr(layers, l) for l in self.Layer]
            for n in reversed(range(self.n_layers)):
                _, current_shape = Layers[n].get_output_padding(current_shape, kernel_size=self.kernel_size[n],
                                                                padding=self.padding[n], dilation=self.dilation[n],
                                                                stride=self.stride[n],
                                                                **self.block_args[n])
        else:
            if self.input_shape is None:
                if self.reshape_method != "none":
                    print('[Warning] could not create flattening module, but reshape_method=%s"%self.reshape_method')
                return
        self.flatten_module = None
        if sum([f % 1.0 for f in current_shape]) > 0:
            print('[Warning] final shape for DeconvEncoder module is non-integer')
        input_shape = (self.channels[0], *([math.ceil(i) for i in current_shape]))
        final_shape = tuple(current_shape.tolist())
        if self.reshape_method == "flatten":
            assert self.target_shape is not None, "target_shape is required when reshape_method == flatten"
            assert self.input_shape, "flattening modules needs the input dimensionality."
            flatten_module = self.flatten_type(self.input_shape, int(np.cumprod(input_shape)[-1]),
                                               **self.config_flatten)
            reshape_module = Reshape(self.channels[0], *final_shape, incoming_dim=1)
            self.flatten_module = nn.Sequential(flatten_module, reshape_module)
        elif self.reshape_method == "channel":
            kernel_size = np.array(input_shape[1:])
            padding = kernel_size - 1
            assert (len(self.input_shape) == 1, "channel unfold mode only works with an 1-d input")
            self.flatten_module = layers.conv_hash['conv'][self.dim](self.input_shape[0], self.channels[0],
                                                                tuple(kernel_size), padding=tuple(padding))
            self.input_shape = (self.input_shape[0], *(1,) * len(final_shape))
        elif self.reshape_method == "pgan":
            kernel_size = np.array(input_shape[1:])
            padding = kernel_size - 1
            assert (len(self.input_shape) == 1, "channel unfold mode only works with an 1-d input")
            flatten_module = [layers.conv_hash['conv'][self.dim](self.input_shape[0], self.channels[0],
                                                                tuple(kernel_size), padding=tuple(padding))]
            for i in range(self.block_args[0].get('n_convs_per_block', 2) - 1):
                flatten_module.append(layers.DeconvLayer([self.channels[0], self.channels[0]],
                                                         dim = self.dim,
                                                         kernel_size=self.kernel_size[0],
                                                         bias=self.bias))
            #reshape_module = Reshape(self.channels[0], *final_shape, incoming_dim=self.dim + 1)
            self.flatten_module = nn.Sequential(*flatten_module)
            self.input_shape = (self.input_shape[0], *(1,) * len(final_shape))
        elif self.reshape_method == "none":
            if self.input_shape is None:
                self.input_shape = [self.channels[0]] + [int(f) for f in final_shape]
            else:
                assert self.input_shape == final_shape, "got input_shape == %s, but final shape is : %s"%(self.input_shape, final_shape)
            self.index_flatten = False
        else:
            raise ValueError("got reshape_method=%s"%self.reshape_method)

        if self.input_shape is None:
            self.input_shape = input_shape

    def _init_final_convs(self):
        out_channels = self.out_channels
        if self.dist_module is not None:
            if hasattr(self.dist_module, "required_channel_upsampling"):
                out_channels *= self.dist_module.required_channel_upsampling

        if self.mode in ["forward"]:
            if len(self.kernel_size) == len(self.channels):
                self.final_conv = layers.conv_hash['conv'][self.dim](self.channels[-1], out_channels,
                                                                     self.kernel_size[-1],
                                                                     padding=int(np.floor(self.kernel_size[-1] / 2)))
            else:
                self.final_conv = layers.conv_hash['conv'][self.dim](self.channels[-1], out_channels, 1)
        else:
            final_convs = []
            if self.has_flatten and self.index_flatten:
                final_convs.append(layers.conv_hash['conv'][self.dim](self.channels[0], out_channels, 1))
            for n in range(1, len(self.channels)):
                final_convs.append(layers.conv_hash['conv'][self.dim](self.channels[n], out_channels, 1))
            self.final_conv = nn.ModuleList(final_convs)

    def forward(self, x: torch.Tensor, mod=None, use_final_conv=True, transition=None, trace=None, **kwargs) -> Union[
        torch.Tensor, dist.Distribution]:
        #TODO make this stronger
        dim = len(checktuple(self.input_shape)) or (self.dim + 1) or len(x.shape) - 1
        batch_shape = x.shape[:-dim]
        # process flattening
        out = x
        if self.flatten_module is not None:
            out = self.flatten_module(x)
        out = out.reshape(-1, *out.shape[-(self.dim + 1):])

        # process convolutions
        hidden = []
        if self.mode == "skip":
            buffer = None
        elif self.mode == "residual":
            buffer = out
        for i, conv_module in enumerate(self.conv_modules):
            # keep last output for transition
            last_out = out if self.mode == "skip" else out
            # perform conv
            if mod is not None:
                if isinstance(mod, (list, tuple)):
                    out = conv_module(out, mod=mod[i])
                else:
                    out = conv_module(out, mod=mod)
            else:
                out = conv_module(out)
            # add to previous outputs for residual connections
            if self.mode == "residual":
                if hasattr(conv_module, "upsample"):
                    buffer = conv_module.upsample(buffer)
                out = out + buffer
                buffer = out
            hidden.append(out)
            if self.mode == "skip":
                # write buffer for skip connections
                if buffer is None:
                    buffer = self.final_conv[i](out)
                else:
                    if hasattr(conv_module, "upsample"):
                        buffer = conv_module.upsample(buffer)
                    buffer = buffer + self.final_conv[i](out)

        # if transitioning, past previous output in last layer upsampling
        if transition and isinstance(self.conv_modules, nn.ModuleList):
            if hasattr(self.conv_modules[-1], "upsample"):
                last_out = self.conv_modules[-1].upsample(last_out)

        # process output
        if hasattr(self, "final_conv") and use_final_conv:
            final_conv = self.final_conv if not isinstance(self.final_conv, nn.ModuleList) else self.final_conv[-1]
            if self.mode in ['skip']:
                out = final_conv(out)
                if transition and isinstance(self.final_conv, nn.ModuleList):
                    if len(self.final_conv) >= 2:
                        # final_conv_idx =
                        out = buffer + (1 - transition) * self.final_conv[-2](last_out) + transition * out
            else:
                out = final_conv(out)
                if transition and isinstance(self.final_conv, nn.ModuleList):
                    if len(self.final_conv) >= 2:
                        out = (1 - transition) * self.final_conv[-2](last_out) + transition * out

        if trace is not None:
            for i, h in enumerate(hidden):
                trace['layer_%d'%i] = h

        #TODO make this stronger
        event_shape = len(self.target_shape) or self.dim+1 or len(out.shape) - len(batch_shape)
        out = out.reshape(*batch_shape, *out.shape[-event_shape:])
        if hasattr(self, "dist_module"):
            if self.dist_module is not None:
                out = self.dist_module(out)

        return out

    def get_submodule(self, items: Union[int, List[int], range]) -> nn.Module:
        if isinstance(items, slice):
            items = list(range(len(self)))[items]
        elif isinstance(items, int):
            if items < 0:
                items = len(self) + items
            items = [items]
        if len(items) == 0:
            raise IndexError("cannot retrieve %s of ConvDecoder")
        config = OmegaConf.create()

        if 0 in items:
            config.input_shape = self.input_shape
        if len(self.conv_modules) - 1 in items:
            config.target_shape = self.target_shape
            config.out_channels = self.out_channels

        # set convolution parameters
        config.dim = self.dim
        offset = 0
        if 0 in items:
            config.channels = [self.channels[i] for i in items]
            offset += (self.has_flatten or self.index_flatten)
        else:
            config.channels = [self.channels[i] for i in items] + [self.channels[items[0] - 1]]
        config.out_channels = self.out_channels
        config.n_layers = len(items)
        config.kernel_size = [self.kernel_size[i - 1] for i in items[offset:]]
        config.dilation = [self.dilation[i - 1] for i in items[offset:]]
        config.padding = [self.padding[i - 1] for i in items[offset:]]
        config.dropout = [self.dropout[i - 1] for i in items[offset:]]
        config.stride = [self.stride[i - 1] for i in items[offset:]]
        config.output_padding = [self.output_padding[i - 1] for i in items[offset:]]
        config.nnlin = [self.nnlin[i - 1] for i in items[offset:]]
        config.norm = [self.norm[i - 1] for i in items[offset:]]
        config.block_args = [self.block_args[i - 1] for i in items[offset:]]
        config.bias = self.bias
        config.mode = self.mode
        config.Layer = self.Layer
        module = type(self)(config, init_modules=False)
        module.flatten_type = None
        module.flatten_module = None

        conv_modules = []
        final_convs = []
        if self.mode in ["skip"]:
            if not 0 in items:
                final_convs.append(self.final_conv[items[0] - (self.has_flatten or self.index_flatten)])
        elif self.mode in ["residual"]:
            final_convs.append(self.final_conv[items[0]])
        for i in items:
            if i == 0:
                module.flatten_type = self.flatten_type
                module.flatten_module = self.flatten_module
                if not (self.has_flatten or self.index_flatten):
                    conv_modules.append(self.conv_modules[i])
            else:
                conv_modules.append(self.conv_modules[i - (self.has_flatten or self.index_flatten)])
            if self.mode in ["skip", "forward+"]:
                final_convs.append(self.final_conv[i])
            if i == len(self) - 1:
                if self.mode in ["forward"]:
                    module.final_conv = self.final_conv
                if hasattr(self, "dist_module") and self.mode in ['forward']:
                    module.dist_module = self.dist_module

        module.conv_modules = nn.ModuleList(conv_modules)
        if self.mode in ["skip", "forward+", "residual"]:
            # final_convs.append(self.final_conv[i+1])
            module.final_conv = nn.ModuleList(final_convs)
            if hasattr(self, 'dist_module'):
                module.dist_module = self.dist_module
        return module
"""