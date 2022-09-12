import abc
from turtle import forward
from typing import Iterable, List
import torch, torch.nn, sys, pdb
sys.path.append('../')
from vschaos.losses.loss import Loss
from vschaos.losses import loss_utils as utils
from vschaos.utils import checklist
import vschaos.distributions as dist

eps = torch.finfo(torch.get_default_dtype()).eps

class ReconstructionLoss(Loss):
    def __init__(self, reduction=None):
        super(ReconstructionLoss, self).__init__(reduction=reduction)

    @property
    @abc.abstractmethod
    def name(self):
        pass

    @abc.abstractmethod
    def forward(self, x, target, drop_detail=False, **kwargs):
        pass


class LogDensity(Loss):
    def __repr__(self):
        return "LogDensity()"

    def forward(self, x, target, drop_detail = False, sample=True):
        if isinstance(target, dist.Distribution):
            if sample:
                if hasattr(target, "rsample"):
                    target = target.rsample()
                else:
                    target = target.sample()
            else:
                target = target.mean
                if target is None:
                    raise ValueError('Could not sample distribution %s in LogDensity'%target)
        ld = self.reduce(-x.log_prob(target))
        if drop_detail:
            return ld, {"log_density": ld.detach().cpu()}
        else:
            return ld

class MSE(Loss):
    def __repr__(self):
        return "MSE()"

    def __init__(self, normalize=None, reduction=None):
        super().__init__(reduction=reduction)
        self.normalize=normalize

    def get_targets(self, x, target, sample=False):
        if isinstance(x, dist.Distribution):
            if sample:
                if x.has_rsample:
                    x = x.rsample()
                else:
                    if x.grad_fn is not None:
                        print('[Warning] sampling a tensor in a graph will cut backpropagation' )
                    x = x.sample()
            else:
                if isinstance(x, dist.Normal):
                    x = x.mean
                elif isinstance(x, (dist.Bernoulli, dist.Categorical)):
                    x = x.probs 
        return x, target

    def forward(self, x, target, drop_detail = False, sample=False, **kwargs):
        x, target = self.get_targets(x, target, sample=sample)
        if self.normalize is not None:
            tens_max = target
            for idx in self.normalize:
                tens_max = tens_max.max(idx).values.unsqueeze(idx)
            if tens_max.nonzero().all():
                x = x / tens_max
                target = target / tens_max
        mse_loss = self.reduce(torch.nn.functional.mse_loss(x, target, reduction="none"))
        if drop_detail:
            return mse_loss, {"mse": mse_loss.detach().cpu()}
        else:
            return mse_loss


class LogMSE(MSE):
    def __repr__(self):
        return "LogMSE()"
    
    def forward(self, x, target, sample=False, **kwargs):
        x, target = self.get_targets(x, target, sample=sample)
        x = x.clamp(eps, None).log()
        target = target.clamp(eps, None).log()
        return super().forward(x, target, sample=sample, **kwargs)


class L1(Loss):
    def __repr__(self):
        return "L1()"

    def __init__(self, normalize=None, reduction=None):
        super().__init__(reduction=reduction)
        self.normalize=normalize

    def get_targets(self, x, target, sample=False):
        if isinstance(x, dist.Distribution):
            if sample:
                if x.has_rsample:
                    x = x.rsample()
                else:
                    if x.grad_fn is not None:
                        print('[Warning] sampling a tensor in a graph will cut backpropagation' )
                    x = x.sample()
            else:
                if isinstance(x, dist.Normal):
                    x = x.mean
                elif isinstance(x, (dist.Bernoulli, dist.Categorical)):
                    x = x.probs 
        return x, target

    def forward(self, x, target, drop_detail = False, sample=False, **kwargs):
        x, target = self.get_targets(x, target, sample=sample)
        if self.normalize is not None:
            tens_max = target
            for idx in self.normalize:
                tens_max = tens_max.max(idx).values.unsqueeze(idx)
            if tens_max.nonzero().all():
                x = x / tens_max
                target = target / tens_max
        l1_loss = self.reduce(torch.nn.functional.l1_loss(x, target, reduction="none"))
        if drop_detail:
            return l1_loss, {"l1": l1_loss.detach().cpu()}
        else:
            return l1_loss

    
class LogL1(L1):
    def __repr__(self):
        return "LogL1()"

    def forward(self, x, target, sample=False, **kwargs):
        x, target = self.get_targets(x, target, sample=sample)
        x = x.clamp(eps, None).log()
        target = target.clamp(eps, None).log()
        return super().forward(x, target, sample=sample, **kwargs)

def frobenius(mat, axis=-1):
    return mat.pow(2).sum(axis).sqrt()

class SpectralConvergence(Loss):
    def __repr__(self):
        return "SpectralConvergence()"

    def __init__(self, reduction=None):
        super().__init__(reduction=reduction)

    def get_targets(self, x, target, sample=False):
        if isinstance(x, dist.Distribution):
            if sample:
                if x.has_rsample:
                    x = x.rsample()
                else:
                    if x.grad_fn is not None:
                        print('[Warning] sampling a tensor in a graph will cut backpropagation' )
                    x = x.sample()
            else:
                if isinstance(x, dist.Normal):
                    x = x.mean
                elif isinstance(x, (dist.Bernoulli, dist.Categorical)):
                    x = x.probs 
        return x, target

    def forward(self, x, target, sample=False, drop_detail=False, **kwargs):
        x, target = self.get_targets(x, target, sample=sample)
        loss = frobenius(x - target) / frobenius(x.abs())
        loss = self.reduce(loss)
        if drop_detail:
            return loss, {'spectral_cv':  loss.detach().cpu()}
        else:
            return loss


class LogISD(Loss):
    def __repr__(self):
        return "LogISD()"

    def __init__(self, reduction=None):
        super().__init__(reduction=reduction)
        self.eps = torch.finfo(torch.get_default_dtype()).eps

    def get_targets(self, x, target, sample=False):
        if isinstance(x, dist.Distribution):
            if sample:
                if x.has_rsample:
                    x = x.rsample()
                else:
                    if x.grad_fn is not None:
                        print('[Warning] sampling a tensor in a graph will cut backpropagation' )
                    x = x.sample()
            else:
                if isinstance(x, dist.Normal):
                    x = x.mean
                elif isinstance(x, (dist.Bernoulli, dist.Categorical)):
                    x = x.probs 
        return x, target

    def forward(self, x, target, sample=False, drop_detail=False, **kwargs):
        x, target = self.get_targets(x, target, sample=sample)
        power_div = (target / x).clamp(self.eps, None)
        loss = (1 / (2 * torch.pi)) * (power_div - power_div.log() - 1)
        loss = self.reduce(loss)
        if drop_detail:
            return loss, {'log_isd':  loss.detach().cpu()}
        else:
            return loss