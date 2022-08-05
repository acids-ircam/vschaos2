from lib2to3.pytree import convert
import sys
sys.path.append('../')
import torch, torch.nn as nn
from vschaos.losses.loss import Loss
from vschaos.distributions import Distribution, convert_to_torch
from torch.distributions import kl_divergence
from typing import Callable, Union

class KLD(Loss):
    def __repr__(self):
        return "KLD()"

    def forward(self, params1: Distribution, params2: Distribution, drop_detail=False, **kwargs) -> torch.Tensor:
        """
        Wrapper for Kullback-Leibler Divergence.
        Args:
            params1 (Distribution): first distribution
            params2: (Distribution) second distribution

        Returns:
            kld (torch.Tensor): divergence output

        """
        reduction = kwargs.get('reduction', self.reduction)
        assert isinstance(params1, Distribution) and isinstance(params2, Distribution), \
            "KLD only works with two distributions"
        params1 = convert_to_torch(params1)
        params2 = convert_to_torch(params2)
        ld = self.reduce(kl_divergence(params1, params2), reduction=reduction)
        if drop_detail:
            return ld, {'kld': ld}
        else:
            return ld


def l2_kernel(x, y, scale=None):
    x_size = x.size(0)
    y_size = y.size(0)
    dim = x.size(1)
    scale = scale or dim
    loss = torch.exp(-(x.unsqueeze(1).expand(x_size, y_size, dim) - y.unsqueeze(0).expand(x_size, y_size, dim)).pow(2) / float(scale))
    return loss

def l2_multiscale_kernel(x, y, scales=[0.2, 0.5, 0.9, 1.3]):
    loss = 0
    for scale in scales:
        loss = loss + l2_kernel(x, y, scale=scale)
    return loss

kernel_hash = {"l2": l2_kernel, "l2_multiscale": l2_multiscale_kernel}


class MMD(Loss):
    def __repr__(self):
        return "MMD(kernel=%s)"%self.kernel

    def __init__(self, kernel: Union[Callable, str] = l2_kernel, *args, reduction: bool = None, **kwargs):
        """
        Maximum Mean Discrepency (MMD) performs global distribution matching, in order to regularize q(z) rather that
        q(z|x). Used in Wasserstein Auto-Encoders.
        Args:
            kernel (Callable or str): kernel used (default: l2_kernel)
        """
        super(MMD, self).__init__(reduction=reduction)
        if isinstance(kernel, str):
            assert kernel in kernel_hash.keys(), "kernel keyword must be %s"%list(kernel_hash.keys())
            kernel = kernel_hash[kernel]
        self.kernel = kernel

    def forward(self, params1: Distribution = None, params2: Distribution = None, drop_detail:bool = False, **kwargs) -> torch.Tensor:
        assert params1, params2
        reduction = kwargs.get('reduction', self.reduction)
        if isinstance(params1, Distribution):
            sample1 = params1.sample() if not params1.has_rsample else params1.rsample()
        if isinstance(params2, Distribution):
            sample2 = params2.sample() if not params2.has_rsample else params2.rsample()
        sample1 = sample1.view(-1, sample1.shape[-1])
        sample2 = sample2.view(-1, sample2.shape[-1])
        dim = sample1.shape[-1]

        x_kernel = self.kernel(sample1, sample1) / (dim * (dim - 1))
        y_kernel = self.kernel(sample2, sample2) / (dim * (dim - 1))
        xy_kernel = self.kernel(sample1, sample2) / (dim * dim)
        loss = self.reduce((x_kernel + y_kernel - 2*xy_kernel).sqrt(), reduction)

        if drop_detail:
            return loss, {'mmd': loss.detach().cpu()}
        else:
            return loss

