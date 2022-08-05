from .normal import Normal

def sample_normal(dist: Normal):
    return dist.rsample()

rsample_hash = {Normal: sample_normal}

def get_rsample_callback(dist_type):
    return rsample_hash[dist_type]