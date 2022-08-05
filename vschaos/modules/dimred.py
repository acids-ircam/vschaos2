import torch, torch.nn as nn
from sklearn import decomposition


class DimRed(nn.Module):
    def __init__(self, **kwargs):
        super().__init__()
    
    def fit(self, x: torch.Tensor):
        pass

    def forward(self, x: torch.Tensor):
        pass

    def invert(self, x: torch.Tensor):
        pass


class PCA(DimRed):
    def __init__(self, input_dim: int, n_components: int = None, **kwargs):
        super().__init__()
        self.skmodule = self._get_decomposition(n_components=n_components, **kwargs)
        self.input_dim = input_dim
        self.n_components = n_components or input_dim
        self.register_buffer("latent_mean", torch.zeros(self.input_dim))
        self.register_buffer("components", torch.zeros(self.n_components, input_dim))

    def _get_decomposition(self, **kwargs):
        return decomposition.PCA(**kwargs)

    def fit(self, x:torch.Tensor) -> None:
        mean_dims = torch.arange(len(x.shape)-1)
        self.latent_mean = x.mean(dim=tuple(mean_dims.tolist()))
        self.skmodule.fit_transform((x-self.latent_mean).detach().cpu().numpy())
        self.components = torch.from_numpy(self.skmodule.components_).to(dtype=torch.get_default_dtype())

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = x - self.latent_mean
        x = torch.matmul(x, self.components.t())
        return x

    @torch.jit.export
    def invert(self, x: torch.Tensor) -> torch.Tensor:
        x = torch.matmul(x, self.components)
        x = x + self.latent_mean
        return x

class ICA(PCA):
    def __init__(self, input_dim: int, n_components: int = None, **kwargs):
        super().__init__(input_dim, n_components=n_components, **kwargs)
        self.register_buffer("mixing", torch.zeros(self.input_dim, self.n_components))

    def _get_decomposition(self, **kwargs):
        return decomposition.FastICA(**kwargs)

    def fit(self, x:torch.Tensor) -> None:
        super().fit(x)
        self.mixing = torch.from_numpy(self.skmodule.mixing_).to(dtype=torch.get_default_dtype())

    @torch.jit.export
    def invert(self, x: torch.Tensor) -> torch.Tensor:
        x = torch.matmul(x, self.mixing.t())
        x = x + self.latent_mean
        return x