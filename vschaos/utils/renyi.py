import math
import warnings
from functools import total_ordering

import torch
from torch._six import inf

from torch.distributions.beta import Beta
from torch.distributions.dirichlet import Dirichlet
from torch.distributions.distribution import Distribution
from torch.distributions.exponential import Exponential
from torch.distributions.gamma import Gamma
from torch.distributions.laplace import Laplace
from torch.distributions.multivariate_normal import MultivariateNormal#, _batch_diag, _batch_mahalanobis,
                                  #_batch_trtrs_lower)
from torch.distributions.normal import Normal
from torch.distributions.transformed_distribution import TransformedDistribution
from torch.distributions.uniform import Uniform
from torch.distributions.utils import _sum_rightmost
from numpy import nan

_RENYI_REGISTRY = {}  # Source of truth mapping a few general (type, type) pairs to functions.
_RENYI_MEMOIZE = {}  # Memoized version mapping many specific (type, type) pairs to functions.


def register_renyi(type_p, type_q):
    """
    Decorator to register a pairwise function with :meth:`renyi_divergence`.
    Usage::
        @register_renyi(Normal, Normal)
        def renyi_normal_normal(p, q):
            # insert implementation here
    Lookup returns the most specific (type,type) match ordered by subclass. If
    the match is ambiguous, a `RuntimeWarning` is raised. For example to
    resolve the ambiguous situation::
        @register_renyi(BaseP, DerivedQ)
        def renyi_version1(p, q): ...
        @register_renyi(DerivedP, BaseQ)
        def renyi_version2(p, q): ...
    you should register a third most-specific implementation, e.g.::
        register_renyi(DerivedP, DerivedQ)(renyi_version1)  # Break the tie.
    Args:
        type_p (type): A subclass of :class:`~torch.distributions.Distribution`.
        type_q (type): A subclass of :class:`~torch.distributions.Distribution`.
    """
    if not isinstance(type_p, type) and issubclass(type_p, Distribution):
        raise TypeError('Expected type_p to be a Distribution subclass but got {}'.format(type_p))
    if not isinstance(type_q, type) and issubclass(type_q, Distribution):
        raise TypeError('Expected type_q to be a Distribution subclass but got {}'.format(type_q))

    def decorator(fun):
        _RENYI_REGISTRY[type_p, type_q] = fun
        _RENYI_MEMOIZE.clear()  # reset since lookup order may have changed
        return fun

    return decorator


@total_ordering
class _Match(object):
    __slots__ = ['types']

    def __init__(self, *types):
        self.types = types

    def __eq__(self, other):
        return self.types == other.types

    def __le__(self, other):
        for x, y in zip(self.types, other.types):
            if not issubclass(x, y):
                return False
            if x is not y:
                break
        return True


def _dispatch_renyi(type_p, type_q):
    """
    Find the most specific approximate match, assuming single inheritance.
    """
    matches = [(super_p, super_q) for super_p, super_q in _RENYI_REGISTRY
               if issubclass(type_p, super_p) and issubclass(type_q, super_q)]
    if not matches:
        return NotImplemented
    # Check that the left- and right- lexicographic orders agree.
    left_p, left_q = min(_Match(*m) for m in matches).types
    right_q, right_p = min(_Match(*reversed(m)) for m in matches).types
    left_fun = _RENYI_REGISTRY[left_p, left_q]
    right_fun = _RENYI_REGISTRY[right_p, right_q]
    if left_fun is not right_fun:
        warnings.warn('Ambiguous renyi_divergence({}, {}). Please register_renyi({}, {})'.format(
            type_p.__name__, type_q.__name__, left_p.__name__, right_q.__name__),
            RuntimeWarning)
    return left_fun


def _infinite_like(tensor):
    """
    Helper function for obtaining infinite renyi Divergence throughout
    """
    return tensor.new_tensor(inf).expand_as(tensor)


def _x_log_x(tensor):
    """
    Utility function for calculating x log x
    """
    return tensor * tensor.log()


def _batch_trace_XXT(bmat):
    """
    Utility function for calculating the trace of XX^{T} with X having arbitrary trailing batch dimensions
    """
    n = bmat.size(-1)
    m = bmat.size(-2)
    flat_trace = bmat.reshape(-1, m * n).pow(2).sum(-1)
    return flat_trace.reshape(bmat.shape[:-2])


def renyi_divergence(p, q, alpha):
    r"""
    Compute Renyi divergence :math:`renyi(p \| q)` between two distributions.
    .. math::
        renyi(p \| q) = \int p(x) \log\frac {p(x)} {q(x)} \,dx
    Args:
        p (Distribution): A :class:`~torch.distributions.Distribution` object.
        q (Distribution): A :class:`~torch.distributions.Distribution` object.
    Returns:
        Tensor: A batch of renyi divergences of shape `batch_shape`.
    Raises:
        NotImplementedError: If the distribution types have not been registered via
            :meth:`register_renyi`.
    """
    try:
        fun = _RENYI_MEMOIZE[type(p), type(q)]
    except KeyError:
        fun = _dispatch_renyi(type(p), type(q))
        _RENYI_MEMOIZE[type(p), type(q)] = fun
    if fun is NotImplemented:
        raise NotImplementedError
    return fun(p, q, alpha)


################################################################################
# renyi Divergence Implementations
################################################################################

_euler_gamma = 0.57721566490153286060

# Same distributions

def lbeta(t1, t2=None):
    if t2 is not None:
        return t1.lgamma() + t2.lgamma() - (t1 + t2).lgamma()
    else:
        return sum([i.lgamma() for i in t1]) - sum(t1).lgamma()


@register_renyi(Beta, Beta)
def _renyi_beta_beta(p, q, alpha):
    # sum_params_p = p.concentration1 + p.concentration0
    # sum_params_q = q.concentration1 + q.concentration0
    # t1 = q.concentration1.lgamma() + q.concentration0.lgamma() + (sum_params_p).lgamma()
    # t2 = p.concentration1.lgamma() + p.concentration0.lgamma() + (sum_params_q).lgamma()
    # t3 = (p.concentration1 - q.concentration1) * torch.digamma(p.concentration1)
    # t4 = (p.concentration0 - q.concentration0) * torch.digamma(p.concentration0)
    # t5 = (sum_params_q - sum_params_p) * torch.digamma(sum_params_p)
    t1 = lbeta(q.concentration0, q.concentration1) - lbeta(p.concentration0, p.concentration1)
    a_alpha = alpha * p.concentration1 + (1-alpha) * q.concentration1
    b_alpha = alpha * p.concentration0 + (1-alpha) * q.concentration0
    t2 = lbeta(a_alpha, b_alpha) - lbeta(p.concentration0, p.concentration1)
    return t1 + (1 / (alpha - 1)) * t2


@register_renyi(Dirichlet, Dirichlet)
def _renyi_dirichlet_dirichlet(p, q, alpha):
    t1 = lbeta(q.concentration) - lbeta(p.concentration)
    t2 = lbeta(alpha * p.concentration + (alpha - 1) * q.concentration) - lbeta(p.concentration)
    return t1 - (1 / (alpha - 1)) * t2


@register_renyi(Exponential, Exponential)
def _renyi_exponential_exponential(p, q, alpha):
    t1 = p.rate.log() - q.rate.log()
    t2 = p.rate.log() - (alpha * p.rate + (1 - alpha) * q.rate).log()
    return t1 - (1 / (alpha - 1)) * t2


@register_renyi(Gamma, Gamma)
def _renyi_gamma_gamma(p, q, alpha):
    # k : concentration ; theta = rate^-1
    t1 = q.concentration.lgamma() + q.concentration * q.rate.reciprocal().log()
    t2 = p.concentration.lgamma() + p.concentration * p.rate.reciprocal().log()
    t3 = (alpha * p.concentration + (1 - alpha)*q.concentration)
    t4 = p.concentration * p.rate.reciprocal.log() + p.concentration.lgamma()
    t5 = t3 * (p.rate.reciprocal().log() + q.rate.reciprocal().log())
    t6 = t3 * (alpha*p.rate.reciprocal() + (1 - alpha)*q.rate.reciprocal()).log()
    return t1 - t2 + (1 / (alpha - 1)) * (t3.lgamma() - t4 + t5 - t6)



@register_renyi(Laplace, Laplace)
def _renyi_laplace_laplace(p, q, alpha):
    if alpha == p.scale / (p.scale + q.scale):
        t1  = q.scale.log() - p.scale.log() + torch.abs(p.loc - q.loc) / q.scale
        t2 = (p.scale + q.scale) / q.scale * ((2*p.scale).log() - (p.scale - q.scale + (p.loc - q.loc).abs()).log())
        return t1 + t2
    else:
        if alpha * q.scale + (1 - alpha) * p.scale < 0:
            return torch.tensor(nan)
        t1 = q.scale.log() - p.scale.log()
        t2 = (alpha / p.scale) * torch.exp( - (1-alpha) * (p.loc - q.loc).abs() / q.scale)
        t3  = ((1-alpha)/ q.scale.log()) * torch.exp(-alpha*(p.loc - q.loc).abs() / p.scale)
        t4 = p.scale.log() + 2*q.scale.log() + (t2 + t3).log()
        t5 = 2*(alpha*q.scale).log() - 2*((1-alpha)*p.scale).log()
        return t1 + (1 / (alpha - 1)) + t4 - t5


@register_renyi(MultivariateNormal, MultivariateNormal)
def _renyi_multivariatenormal_multivariatenormal(p, q, alpha):
    # From https://en.wikipedia.org/wiki/Multivariate_normal_distribution#Kullback%E2%80%93Leibler_divergence
    if p.event_shape != q.event_shape:
        raise ValueError("renyi-divergence between two Multivariate Normals with\
                          different event shapes cannot be computed")
    t1 = (alpha * p.covariance_matrix + (1-alpha)*q.covariance_matrix)
    t2 = (alpha / 2)*(p.mean - q.mean).transpose() @ t1 @ (p.mean - q.mean)
    t3 = (1 / (2 * (alpha - 1))) * (torch.logdet(t1) - (1 - alpha)*torch.logdet(p.covariance_matrix) - alpha*torch.logdet(q.covariance_matrix))
    return t2 - t3


    # half_term1 = (_batch_diag(q._unbroadcasted_scale_tril).log().sum(-1) -
    #               _batch_diag(p._unbroadcasted_scale_tril).log().sum(-1))
    # combined_batch_shape = torch._C._infer_size(q._unbroadcasted_scale_tril.shape[:-2],
    #                                             p._unbroadcasted_scale_tril.shape[:-2])
    # n = p.event_shape[0]
    # q_scale_tril = q._unbroadcasted_scale_tril.expand(combined_batch_shape + (n, n))
    # p_scale_tril = p._unbroadcasted_scale_tril.expand(combined_batch_shape + (n, n))
    # term2 = _batch_trace_XXT(_batch_trtrs_lower(p_scale_tril, q_scale_tril))
    # term3 = _batch_mahalanobis(q._unbroadcasted_scale_tril, (q.loc - p.loc))
    # return half_term1 + 0.5 * (term2 + term3 - n)


@register_renyi(Normal, Normal)
def _renyi_normal_normal(p, q, alpha):
    t1 = q.stddev.log()-p.stddev.log()
    t2 = (alpha * q.variance + (1-alpha)*p.variance)
    t3 = 1 / (2 * (alpha - 1)) * (q.variance.log() - t2.log())
    t4 = 0.5 * (alpha * (p.mean - q.mean)**2) / t2
    return t1 + t3 + t4


@register_renyi(TransformedDistribution, TransformedDistribution)
def _renyi_transformed_transformed(p, q, alpha):
    if p.transforms != q.transforms:
        raise NotImplementedError
    if p.event_shape != q.event_shape:
        raise NotImplementedError
    # extra_event_dim = len(p.event_shape) - len(p.base_dist.event_shape)
    extra_event_dim = len(p.event_shape)
    base_renyi_divergence = renyi_divergence(p.base_dist, q.base_dist)
    return _sum_rightmost(base_renyi_divergence, extra_event_dim)


@register_renyi(Uniform, Uniform)
def _renyi_uniform_uniform(p, q, alpha):
    if alpha >= 0 and alpha <= 1:
        t1 = (q.high - q.low).log() + (p.high - p.low).log()
        t2 = 1/(alpha - 1) * (torch.min(p.high, q.high) - torch.max(p.min, q.min)).log() - (p.high - p.mean).log()
        return t1 + t2
    else:
        if p.low < q.low or p.high > q.high:
            return torch.tensor(nan)
        return (q.high - q.low).log() - (p.high - p.low)
    return result