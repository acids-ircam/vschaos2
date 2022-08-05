from random import random
import sys
print(sys.path)
sys.path.insert(0, ".")
import torch.distributions as dist_torch
from active_divergence import distributions as dist
from torch.distributions.utils import probs_to_logits, logits_to_probs

import matplotlib.pyplot as plt
plt.ioff()
import torch, pytest, torch.nn as nn

closeall_tolerance = 1e-4

class DistModule(nn.Module):
    def __init__(self):
        super().__init__()
    def get_distribution(self, x):
        return NotImplemented
    def forward(self, x: torch.Tensor):
        dist = self.get_distribution(x)
        samples = dist.sample()
        ll = dist.log_prob(samples)
        return dist


## Testing uniform distribution
class UniformModule(DistModule):
    def get_distribution(self, x):
        return dist.Uniform(torch.full_like(x, -1), torch.full_like(x, 1))

def check_uniform_dist(min, max, path, name):
    unif_dist = dist.Uniform(min, max)
    norm_samples = unif_dist.rsample()
    hist_range = [float(min.min()), float(max.max())]
    histogram = torch.histogram(norm_samples, 100, range=hist_range, density=True)
    hist_bin = (histogram.bin_edges[1:] + histogram.bin_edges[:-1])/2
    plt.bar(hist_bin, histogram.hist, width=float(hist_bin[1] - hist_bin[0]))
    plt.savefig(f"{path}/{name}.pdf")
    plt.close('all')
    # check log_density
    random_tensor = unif_dist.sample()
    unif_dist_torch = dist_torch.Uniform(min, max)
    assert torch.allclose(unif_dist.log_prob(random_tensor), unif_dist_torch.log_prob(random_tensor))

uniform_params = [(torch.full((50000,), -1.), torch.full((50000,), 1.), "centered")]

def test_uniform(test_path):
    for min_val, max_val, name in uniform_params:
        check_uniform_dist(min_val, max_val, test_path, "uniform_"+name)
    module = NormalModule()
    module_scripted = torch.jit.script(module)


## Testing normal distributions

normal_params = [(torch.zeros(50000), torch.ones(50000), "isotropic"),
                 (torch.full((50000,), 3.), torch.full((50000,), 1.e-3), "narrow_positive"),
                 (torch.full((50000,), -1.), torch.full((50000,), 5.), "wide_negative")]

class NormalModule(DistModule):
    def get_distribution(self, x):
        return dist.Normal(torch.zeros_like(x), torch.ones_like(x))

def check_normal_dist(mean, var, path, name):
    norm_dist = dist.Normal(mean, var)
    norm_samples = norm_dist.rsample()
    hist_range = [float(norm_samples.min()), float(norm_samples.max())]
    histogram = torch.histogram(norm_samples, 100, range=hist_range, density=True)
    hist_bin = (histogram.bin_edges[1:] + histogram.bin_edges[:-1])/2
    plt.bar(hist_bin, histogram.hist, width=float(hist_bin[1] - hist_bin[0]))
    plt.savefig(f"{path}/{name}.pdf")
    plt.close('all')
    # check log_density
    random_tensor = norm_dist.sample()
    norm_dist_torch = dist_torch.Normal(mean, var)
    assert torch.allclose(norm_dist.log_prob(random_tensor), norm_dist_torch.log_prob(random_tensor))

def test_normal(test_path):
    for mean, var, name in normal_params:
        check_normal_dist(mean, var, test_path, "normal_"+name)
    # test scripting
    module = NormalModule()
    module_scripted = torch.jit.script(module)


## Testing bernoulli distribution
class BernoulliProbModule(DistModule):
    def get_distribution(self, x):
        return dist.Bernoulli(probs=torch.rand_like(x))

class BernoulliLogitsModule(DistModule):
    def get_distribution(self, x):
        return dist.Bernoulli(logits=torch.randn_like(x))

def check_bernoulli_dist_probs(probs, path, name):
    ber_dist = dist.Bernoulli(probs=probs)
    norm_samples = ber_dist.sample()
    histogram = torch.histogram(norm_samples, 2, range=[0., 1.], density=True)
    plt.bar([0., 1.], histogram.hist, width=0.5)
    plt.savefig(f"{path}/{name}.pdf")
    plt.close('all')
    # check log_density
    random_tensor = ber_dist.sample()
    ber_dist_torch = dist_torch.Bernoulli(probs=probs)
    assert torch.allclose(ber_dist.log_prob(random_tensor), ber_dist_torch.log_prob(random_tensor))

def check_bernoulli_dist_logits(logits, path, name):
    ber_dist = dist_torch.Bernoulli(logits=logits)
    norm_samples = ber_dist.sample()
    histogram = torch.histogram(norm_samples, 2, range=[0., 1.], density=True)
    plt.bar([0., 1.], histogram.hist, width=0.5)
    plt.savefig(f"{path}/{name}.pdf")
    plt.close('all')
    # check log_density
    random_tensor = ber_dist.sample()
    ber_dist_torch = dist_torch.Bernoulli(logits=logits)
    assert torch.allclose(ber_dist.log_prob(random_tensor), ber_dist_torch.log_prob(random_tensor))

bernoulli_params = [(torch.full((50000,), 0.1), "odd"),
                    (torch.full((50000,), 0.5), "central"),
                    (torch.full((50000,), 0.9), "even")]

def test_bernoulli(test_path):
    for probs, name in bernoulli_params:
        check_bernoulli_dist_probs(probs, test_path, "bernoulli_probs_"+name)
        check_bernoulli_dist_logits(probs_to_logits(probs), test_path, "bernoulli_logits_"+name)
    module = BernoulliProbModule()
    module_scripted = torch.jit.script(module)
    module_scripted(torch.randn(10, 10, 10))
    module = BernoulliLogitsModule()
    module_scripted = torch.jit.script(module)
    module_scripted(torch.randn(10, 10, 10))



## Testing bernoulli distribution
class CategoricalProbsModule(DistModule):
    def get_distribution(self, x):
        return dist.Bernoulli(probs=torch.rand_like(x))

# class CategoricalLogitsModule(DistModule):
#     def get_distribution(self, x):
#         return dist.Bernoulli(logits=torch.randn_like(x))

def check_categorical_dist_probs(probs, path, name):
    cat_dist = dist.Categorical(probs=probs)
    cat_samples = cat_dist.sample()
    classes = list(range(probs.size(-1)))
    count = [(cat_samples == x).nonzero().numel() for x in classes]
    plt.bar(classes, count, width=1)
    plt.savefig(f"{path}/{name}.pdf")
    plt.close('all')
    # check log_density
    random_tensor = cat_dist.sample()
    cat_dist_torch = dist_torch.Categorical(probs=probs)
    assert torch.allclose(cat_dist.log_prob(random_tensor), cat_dist_torch.log_prob(random_tensor))

def check_categorical_dist_logits(probs, path, name):
    cat_dist = dist.Categorical(logits=probs)
    cat_samples = cat_dist.sample()
    classes = list(range(probs.size(-1)))
    count = [(cat_samples == x).nonzero().numel() for x in classes]
    plt.bar(classes, count, width=1)
    plt.savefig(f"{path}/{name}.pdf")
    plt.close('all')
    # check log_density
    random_tensor = cat_dist.sample()
    cat_dist_torch = dist_torch.Categorical(logits=probs)
    assert torch.allclose(cat_dist.log_prob(random_tensor), cat_dist_torch.log_prob(random_tensor))

categorical_params= [(torch.cat([torch.full((50000,5), 0.1), torch.full((50000,1), 1.0), torch.full((50000,4), 0.1)], -1) , "class_six"),
                     (torch.cat([torch.full((50000,1), 0.1), torch.full((50000,1), 1.0), torch.full((50000,8), 0.1)], -1) , "class_two"),
                     (torch.full((50000,10), 0.1), "uniform")]

def test_categorical(test_path):
    for probs, name in categorical_params:
        check_categorical_dist_probs(probs, test_path, "categorical_probs_"+name)
        check_categorical_dist_logits(probs_to_logits(probs), test_path, "categorical_logits_"+name)
    module = BernoulliProbModule()
    module_scripted = torch.jit.script(module)
    module_scripted(torch.randn(10, 10, 10))
    module = BernoulliLogitsModule()
    module_scripted = torch.jit.script(module)
    module_scripted(torch.randn(10, 10, 10))