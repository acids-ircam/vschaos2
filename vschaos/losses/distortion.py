import abc
from typing import Iterable, List
import torch, torch.nn, sys, pdb
sys.path.append('../')
from vschaos.losses.loss import Loss
from vschaos.losses import loss_utils as utils
from vschaos.utils import checklist
import vschaos.distributions as dist


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

    def forward(self, x, target, drop_detail = False, sample=False, **kwargs):
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
