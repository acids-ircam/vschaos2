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

class Spherical(DimRed):
    def forward(self, x: torch.Tensor):
        x_sph = torch.zeros_like(x)
        x_sph[..., 0] = x.pow(2).sum(-1).sqrt()
        for i in range(0, x.size(-1)-1):
            if i != x.size(-1) - 2:
                x_sph[..., i+1] = torch.acos(x[..., i] / (x[..., i:].pow(2).sum(-1)).sqrt())
            else:
                val = torch.acos(x[..., -2] / (x[..., -2:].pow(2).sum(-1).sqrt()))
                x_sph[..., i+1] = torch.where(x[..., -1] >= 0, val, 2 * torch.pi - val)
        # convert to degrees
        x_sph[..., 1:] = (180 / torch.pi) * x_sph[..., 1:] 
        return x_sph

    def invert(self, x_sph: torch.Tensor):
        # convert to radians
        x_sph[..., 1:] = (torch.pi/180) * x_sph[..., 1:]
        x = torch.zeros_like(x_sph)
        accum = torch.ones_like(x[..., 0])
        for i in range(x_sph.size(-1)):
            if (i != x_sph.size(-1) - 1):
                x[..., i] = x_sph[..., 0] * accum * x_sph[..., i+1].cos()
                accum = accum * x_sph[..., i+1].sin()
            else:
                x[..., i] = x_sph[..., 0] * accum *  x_sph[..., i].sin()
        return x_sph