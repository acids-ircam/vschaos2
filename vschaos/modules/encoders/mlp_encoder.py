import torch, torch.nn as nn, numpy as np
from omegaconf import OmegaConf
from typing import Union 
from vschaos.utils import checklist, checksize, checkdist, reshape_batch, flatten_batch
from vschaos.modules import layers as layers, mlp_dist_hash 
import vschaos.distributions as dist

class MLPEncoder(nn.Module):
    Layer = layers.MLP
    available_distributions = [dist.Bernoulli, dist.Categorical, dist.Normal]

    def __init__(self, config: OmegaConf, **kwargs):
        """
        Feed-forward encoder for auto-encoding architectures. OmegaConfuration may include:
        input_shape : input dimensionality
        nlayers : number of layers (default: 3)
        hidden_dims: hidden dimensions (default: 800)
        nnlin: non-linearity (default : SiLU)
        norm: normalization ("batch" for batch norm)
        target_shape: target shape of encoder
        target_dist:  target distribution of encoder
        Args:
            config (OmegaConf): encoder configuration.
        """
        super(MLPEncoder, self).__init__()
        self.input_shape = checksize(config.input_shape)
        self.nlayers = config.get('nlayers', 3)
        self.hidden_dims = config.get('hidden_dims', 800)
        self.nnlin = checklist(config.get('nnlin') or layers.DEFAULT_NNLIN, n=self.nlayers)
        self.nnlin.append(None)
        self.out_nnlin = None if config.get('out_nnlin') is None else getattr(nn, config.get('out_nnlin'))()
        self.norm = config.get('norm')
        self.dropout = config.get('dropout')
        self.target_dist = checkdist(config.get('target_dist'))
        self.dist_module = mlp_dist_hash[self.target_dist](out_nnlin=self.out_nnlin)
        self.weight_norm = config.get('weight_norm', False)
        self.target_shape = checksize(config.get('target_shape'))
        assert self.target_shape is not None
        self.layer = self.Layer if config.get('layer') is None else getattr(layers, config.layer)
        self._init_modules()

    def _init_modules(self):
        input_shape = self.input_shape
        if isinstance(input_shape, torch.Size):
            input_shape = np.cumprod(list(input_shape))[-1]
        target_shape = np.cumprod(list(self.target_shape))[-1]
        target_shape = target_shape if self.target_dist not in [dist.Normal] else target_shape * 2
        self.mlp = self.Layer(input_shape, target_shape, nlayers=self.nlayers, dim=self.hidden_dims,
                              nnlin=self.nnlin, norm=self.norm, dropout=self.dropout, weight_norm=self.weight_norm)

    def forward(self, x: torch.Tensor):
        batch_shape = torch.Size([0])
        if x.ndim > 2:
            mlp_in, batch_shape = flatten_batch(x, dim=-1)
        else:
            mlp_in = x
        hidden = self.mlp(mlp_in)
        if x.ndim > 2:
            hidden = reshape_batch(hidden, batch_shape, dim=-1)
        out = self.dist_module(hidden)
        return out
        
    @torch.jit.ignore
    def __call__(self, x: torch.Tensor, return_hidden=False, trace=None, **kwargs) -> Union[torch.Tensor, dist.Distribution]:
        """
        Encodes incoming tensor.
        Args:
            x (torch.Tensor): data to encode

        Returns:
            y (torch.Tensor or Distribution): encoded data.
        """
        batch_shape = x.shape[:-len(self.input_shape)]
        hidden = self.mlp(x, return_hidden=return_hidden, trace=trace)
        if return_hidden:
            hidden, hidden_history = hidden
        hidden = hidden.reshape(*batch_shape, hidden.shape[-1])
        out = self.dist_module(hidden)
        if return_hidden:
            return out, hidden_history
        else:
            return out



class MLPDecoder(MLPEncoder):
    pass