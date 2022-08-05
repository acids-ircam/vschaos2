import torch, torch.nn as nn

class TimeEmbedding(nn.Module):
    def __init__(self, out_dim, f_scale: float = 1.0, t_scale: float = 1.0):
        super().__init__()
        assert out_dim %2 == 1, "out dimension of TimeEmbedding must be odd"
        self.out_dim = out_dim
        self.n_freqs = (self.out_dim - 1) / 2
        self.f_scale = f_scale
        self.t_scale = t_scale

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        if x.size(-1) != 1:
            x = x.unsqueeze(-1)
        x = x / self.t_scale
        repeat_args = (1,) * (len(x.size()) - 1) + (int((self.out_dim - 1) / 2),)
        x_cos = torch.cos(x.repeat(repeat_args) * self.f_scale * torch.arange(self.n_freqs))
        x_sin = torch.sin(x.repeat(repeat_args) * self.f_scale * torch.arange(self.n_freqs))
        return torch.cat([x * 2 - 1, x_cos, x_sin], -1)

        
