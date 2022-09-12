import torch, torch.nn as nn, vschaos.distributions as dist
from typing import Union

class Dumb(nn.Module):
    def __init__(self, out_nnlin: Union[nn.Module, None] = None, **kwargs) -> None:
        super().__init__()
        self.out_nnlin: Union[None, nn.Module]= out_nnlin
    def forward(self, x: torch.Tensor):
        if self.out_nnlin is not None:
            x = self.out_nnlin(x)
        return x

class MLPBernoulli(nn.Module):
    def __init__(self, out_nnlin: Union[nn.Module, None] = None, dim: int = None):
        """
        embeds the output of an MLP as a Bernoulli distribution.
        Args:
            out_nnlin (nn.Module) : non-linearity used (default : nn.Sigmoid())
        """
        super(MLPBernoulli, self).__init__()
        self.out_nnlin = out_nnlin or nn.Sigmoid()
        self.dim = dim

    @property
    def required_dim_upsampling(self):
        return 1
    
    @property
    def required_channel_upsampling(self):
        return 1

    def forward(self, out: torch.Tensor) -> dist.Bernoulli:
        if self.out_nnlin is not None:
            out = self.out_nnlin(out)
        return dist.Bernoulli(out)

class ConvBernoulli(MLPBernoulli):
    def __init__(self, out_nnlin: Union[nn.Module, None] = None, dim: int = None):
        """
        embeds the output of a convolutional module as a Bernoulli distribution.
        Args:
            out_nnlin (nn.Module) : non-linearity used (default : nn.Sigmoid())
        """
        super().__init__(out_nnlin, dim)


class MLPNormal(nn.Module):
    variance_modes = ['none', 'logvar', 'sigm3', 'sig']
    def __init__(self, out_nnlin: Union[nn.Module, None], dim: int = -1, varmode: str = "sig"):
        """
        embeds the output of an MLP as a Normal distribution. Splits the last dimension in 2 to obtain mu and variance.
        Args:
            out_nnlin (nn.Module) : non-linearity used (default : nn.Sigmoid())
            varmode (str): variance encoding mode (options : none | logvar | sigm3 | sig)
        """
        super(MLPNormal, self).__init__()
        self.out_nnlin = out_nnlin
        assert varmode in self.variance_modes
        self.varmode = varmode
        self.dim = dim
        self.eps = torch.finfo(torch.get_default_dtype()).eps

    @property
    def required_dim_upsampling(self):
        return 2

    @property
    def required_channel_upsampling(self):
        return 1

    def forward(self, out: torch.Tensor) -> dist.Normal:
        mu, std = out.split(out.shape[-1]//2, dim=self.dim)
        if self.out_nnlin is not None:
            mu = self.out_nnlin(mu)
        if self.varmode == "logvar":
            std = torch.sqrt(torch.exp(std) + self.eps)
        elif self.varmode == "sig":
            std = torch.clamp(torch.sigmoid(std), self.eps, None)
        elif self.varmode == "sigm3":
            std = torch.clamp(torch.sigmoid(std-1), self.eps, None)
        else:
            print('unknown variance mode in MLPNormal : %s'%self.varmode)
        return dist.Normal(mu, std)


class ConvNormal(nn.Module):
    variance_modes = ['none', 'logvar', 'sigm3', 'sig']
    def __init__(self, out_nnlin: Union[nn.Module, None] = None, varmode="sigm3", dim: int = None):
        """
        embeds the output of a convolutional module as a Normal distribution.
        splits the channel dimension in 2 to obtain mu and variance.
        Args:
            out_nnlin (nn.Module) : non-linearity used (default : nn.Sigmoid())
            varmode (str): variance encoding mode (options : none | logvar | sigm3 | sig)
            dim (int): channel dimension (default: 1)
        """
        super(ConvNormal, self).__init__()
        self.out_nnlin = out_nnlin
        self.varmode = varmode
        self.dim = dim
        self.eps = torch.finfo(torch.get_default_dtype()).eps

    @property
    def required_channel_upsampling(self):
        return 2

    @property
    def required_dim_upsampling(self):
        return 1

    def forward(self, out: torch.Tensor) -> dist.Normal:
        dim = 1 if self.dim is None else -(self.dim + 1)
        mu, std = out.split(out.shape[dim]//2, dim=dim)
        if self.out_nnlin is not None:
            mu = self.out_nnlin(mu)
        if self.varmode == "logvar":
            std = torch.sqrt(torch.exp(std) + self.eps)
        elif self.varmode == "sig":
            std = torch.sigmoid(std)
        elif self.varmode == "sigm3":
            std = torch.sigmoid(std-3) + 1e-6
        return dist.Normal(mu, std)

class MLPCategorical(nn.Module):
    def __init__(self, out_nnlin: Union[nn.Module, None], logits=False, dim=-1):
        """
        embeds the output of an MLP as  a Categorical distribution.
        Args:
            out_nnlin (nn.Module) : non-linearity used (default : None if logits, or nn.Sigmoid())
            logits (bool): logit mode (default nn-linearity is disabled)
            dim (str): categorical dimension (default: -1)
        """
        super(MLPCategorical, self).__init__()
        self.out_nnlin = out_nnlin or (nn.Softmax(dim=-1) if not logits else None)
        self.logits = logits
        self.dim = dim

    @property
    def required_dim_upsampling(self):
        return 1
    
    @property
    def required_channel_upsampling(self):
        return 1

    def forward(self, out):
        if self.out_nnlin is not None:
            out = self.out_nnlin(out)
        if self.logits:
            return dist.Categorical(logits=out)
        else:
            return dist.Categorical(probs=out)

class ConvCategorical(MLPCategorical):

    def __init__(self, out_nnlin: Union[nn.Module, None]=None, logits=False, dim=-1):
        """
        embeds the output of a convolutional module as a Categorical distribution.
        Args:
            out_nnlin (nn.Module) : non-linearity used (default : None if logits, or nn.Sigmoid())
            logits (bool): logit mode (default nn-linearity is disabled)
            dim (str): categorical dimension (default: -1)
        """
        super().__init__(out_nnlin, logits, dim)


conv_dist_hash = {dist.Bernoulli: ConvBernoulli, dist.Normal: ConvNormal, dist.Categorical: ConvCategorical, None: Dumb}
mlp_dist_hash = {dist.Bernoulli: MLPBernoulli, dist.Normal: MLPNormal, dist.Categorical: MLPCategorical, None: Dumb}