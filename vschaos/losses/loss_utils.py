import torch

__all__ = ['logmag_l1', 'logmag_l2', 'mag_l1', 'mag_l2', 'phase_l1', 'phase_l2',
           'if_l1', 'if_l2', 'spectral_convergence', 'weighted_phase', 'log_isd']

def frobenius(mat, axis=-1):
    return mat.pow(2).sum(axis).sqrt()

def logmag_l1(x_input, x_target):
    return torch.abs(x_input.abs().log() - x_target.abs().log()).sum(-1)

def logmag_l2(x_input, x_target):
    return torch.sqrt((x_input.abs().log() - x_target.abs().log()).pow(2).sum(-1))

def mag_l1(x_input, x_target):
    return torch.abs(x_input.abs() - x_target.abs()).sum(-1)

def mag_l2(x_input, x_target):
    return torch.sqrt((x_input.abs() - x_target.abs()).pow(2).sum(-1))

def phase_l1(x_input, x_target):
    return torch.abs(x_input.angle() - x_target.angle()).sum(-1)

def phase_l2(x_input, x_target):
    return torch.sqrt((x_input.angle() - x_target.angle()).pow(2).sum(-1))

def if_l1(x_input, x_target):
    return torch.zeros_like(x_input).sum(-1).abs()

def if_l2(x_input, x_target):
    return torch.zeros_like(x_input).sum(-1).abs()

def spectral_convergence(x_input, x_target):
    return frobenius(x_input.abs() - x_target.abs()) / frobenius(x_input.abs())

def weighted_phase(x_input, x_target):
    return torch.abs(x_input.abs() * x_target.abs() - x_input.real * x_target.real - x_input.imag * x_target.imag)

def log_isd(x_input, x_target):
    power_div = x_target.abs() / x_input.abs()  
    return (1 / (2 * torch.pi)) * (power_div - power_div.log() - 1).sum(-1)