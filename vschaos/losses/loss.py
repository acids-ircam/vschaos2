import torch, torch.nn as nn, abc, re, types
from typing import Union, Iterable
from ..utils import checklist


class Loss(nn.Module):
    def __init__(self, reduction=None):
        super().__init__()
        self.reduction = reduction

    def reduce(self, loss, **kwargs) -> None:
        if "reduction" in kwargs:
            reduction = kwargs['reduction']
        else:
            reduction = self.reduction
        if reduction is None:
            return loss.mean(0).sum()
        elif reduction == "mean":
            return loss.mean()
        elif reduction == "seq":
            return loss.mean(0).mean(1).sum()

    @abc.abstractmethod
    def forward(self, *args, drop_detail: bool = False, **kwargs):
        pass

    def __add__(self, other):
        if type(other) == LossContainer:
            return other.__radd__(self)
        elif isinstance(other, Loss):
            return LossContainer(criterions=[self, other], weight=[1.0, 1.0])
        else:
            raise TypeError

    def __mul__(self, other):
        if isinstance(other, (int, float)):
            return LossContainer(criterions=[self], weight=[other])
        else:
            raise TypeError

    def __rmul__(self, other):
        return self.__mul__(other)

    def __truediv__(self, other):
        if isinstance(other, (int, float)):
            return self.__mul__(1 / other)
        else:
            raise TypeError


class LossContainer(Loss):
    def __init__(self, criterions: Iterable[Loss] = None, weight: Union[float, Iterable[float]] = 1.0, **kwargs):
        super(LossContainer, self).__init__(**kwargs)
        assert criterions is not None, '"criterions" keyword is required for LossContainer'
        self._criterions = criterions
        self._weight = checklist(weight, n=len(self._criterions))

    def _append_losses(self, full_dict: dict, new_dict: dict) -> dict:
        full_dict = dict(full_dict)
        for k, v in new_dict.items():
            matches = list(filter(lambda x: (x is not None) and (x != ""), [re.match(r"%s#(\d*)"%k, k_tmp) for k_tmp in full_dict.keys()]))
            if len(matches) != 0:
                last_v = max([int(x.groups()[1]) for x in matches])
                full_dict[f"{k}#{last_v+1}"] = v
            elif k in full_dict:
                full_dict[f"{k}#1"] = v
            else:
                full_dict[k] = v
        return full_dict

    def forward(self, *args, drop_detail: bool = False, **kwargs):
        losses = []
        loss = 0
        for i, criterion in enumerate(self._criterions):
            loss_tmp = criterion(*args, drop_detail=drop_detail, **kwargs)
            if drop_detail:
                loss_tmp, losses_tmp = loss_tmp
                losses.append(losses_tmp)
            loss = loss + self._weight[i] * loss_tmp
        if drop_detail:
            loss_dict = {}
            for lt in losses:
                loss_dict = self._append_losses(loss_dict, lt)
            return loss, loss_dict
        else:
            return loss

    def __add__(self, other):
        if isinstance(other, Loss):
            return LossContainer(criterions=self._criterions+[other], weight=self._weight +[1.0])
        elif isinstance(other, LossContainer):
            return LossContainer(criterions=self._criterions + other._criterions, weight= self._weight + other._weight)
        else:
            raise TypeError

    def __radd__(self, other):
        return self.__add__(other)

    def __mul__(self, other):
        if isinstance(other, (int, float)):
            self._weight = [w * other for w in self._weight]

    def __truediv__(self, other):
        if isinstance(other, (int, float)):
            self.__mul__(1 / other)

    def __rdiv__(self, other):
        if isinstance(other, (int, float)):
            self.__rmul__(1 / other)


