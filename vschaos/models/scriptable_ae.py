from argparse import ArgumentParser
import torch, torch.nn as nn
import nn_tilde, acids_transforms as at
from vschaos.modules.dimred import Spherical
from vschaos.distributions import Distribution
from ..utils import reshape_batch, flatten_batch, checklist
from .auto_encoders import AutoEncoder
from typing import Union, Callable, List, Tuple

TYPE_HASH = {
    bool: 0,
    int: 1,
    float: 2,
    str: 3,
    torch.Tensor: 4
}

def retrieve_oaparams_from_transform(transform, inversion_mode: str = None):
    if transform is None:
        return None, None
    win_length = None
    hop_length = None
    if isinstance(transform, at.ComposeAudioTransform):
        for t in transform.transforms:
            win_length, hop_length = retrieve_oaparams_from_transform(t, inversion_mode=inversion_mode)
            if win_length is not None:
                break
    else:
        if hasattr(transform, "n_fft"):
            win_length = int(transform.n_fft)
            if hasattr(transform, "hop_length"):
                hop_length = int(transform.hop_length)
            else:
                hop_length = win_length // 4
            if inversion_mode is not None:
                transform.inversion_mode = inversion_mode
    return win_length, hop_length

def reshape_cond(label, target_x):
    repeat_args = [1] * len(label.shape)
    label = label.unsqueeze(-1)
    repeat_args += [target_x.shape[-1]]
    return label.repeat(repeat_args)

class EmbeddingWrapper(nn.Module):
    def __init__(self, embedding_module):
        super().__init__()
        self.embedding_module = embedding_module
        self.needs_long = False
        if type(embedding_module) in [torch.nn.Embedding, at.OneHot]:
            self.needs_long = True

    def forward(self, x: torch.Tensor):
        x = x.mean(-1)
        if self.needs_long:
            x = x.long()
        return self.embedding_module.forward(x)
    def invert(self, x: torch.Tensor):
        return self.embedding_module.invert(x)

class DimredWrapper(nn.Module):
    def __init__(self, dimred_module):
        super().__init__()
        self.dimred_module = dimred_module

    def forward(self, x: torch.Tensor):
        return self.dimred_module.forward(x)

    def invert(self, x: torch.Tensor):
        return self.dimred_module.invert(x)

class ScriptableSpectralAutoEncoder(nn_tilde.Module):
    def __init__(self, 
                auto_encoder: AutoEncoder,
                transform: Union[Callable, None] = None, 
                use_oa: bool = True,
                win_length: int = None,
                hop_length: int = None,
                inversion_mode: str = "keep_input",
                use_dimred: bool = None,
                export_for_nn: bool = True):

        super().__init__()
        # Main parameters
        self.input_shape = list(auto_encoder.input_shape)
        self.latent_dim = int(auto_encoder.config.latent.dim)

        # Init transforms
        self.transform = transform
        if transform is not None:
            self.win_length, self.hop_length = retrieve_oaparams_from_transform(transform, inversion_mode=inversion_mode)
        else:
            self.win_length, self.hop_length = win_length, hop_length
        # overlap add
        self.use_oa = use_oa
        if use_oa:
            assert self.win_length is not None, "use_oa=True but could not retrieve win_length"
            self.overlap_add = at.OverlapAdd(self.win_length, self.hop_length)
            self.transform = self.transform.realtime()
        self.spectral_transform_idx = self._get_spectral_transform(self.transform)

        # Init encoder & decoders
        self.encoder = auto_encoder.encoder
        self.encoder_type = auto_encoder.encoder.target_dist
        self.decoder = auto_encoder.decoder
        self.decoder_type = auto_encoder.encoder.target_dist
        
        # Init conditionings
        self.conditionings = auto_encoder.conditionings
        self.concat_embeddings = nn.ModuleDict()
        for task, embedding in auto_encoder.concat_embeddings.items():
            self.concat_embeddings[task] = EmbeddingWrapper(embedding)
        self.prediction_modules = nn.ModuleDict()

        # Init prediction modules
        if hasattr(auto_encoder, "prediction_modules"):
            self.prediction_modules = auto_encoder.prediction_modules

        # Init dimensionality reduction
        self.dimreds = nn.ModuleDict()
        if hasattr(auto_encoder, "dimreds"):
            for k, v in auto_encoder.dimreds.items():
                self.dimreds[k] = DimredWrapper(v)
        self.dimreds['spherical'] = Spherical()
        if use_dimred is None:
            use_dimred = auto_encoder.config.latent.dim >= 8
        self.use_dimred = use_dimred

        # set intern buffers
        self._set_buffers(auto_encoder)

        # set nn~ parameters
        self._decode_available = True
        self._encode_available = True
        self._forward_available = True
        self.export_for_nn = export_for_nn

        # set parameters & attributes
        self._set_params(auto_encoder)
        self._set_attributes(auto_encoder)

    # attributes & buffers
    def _set_buffers(self, auto_encoder):
        # dim reduction parameters
        self.register_buffer("temperature", torch.tensor(0.))
        self.register_buffer("latent_mean", auto_encoder.latent_mean)
        if hasattr(auto_encoder, "fidelity"):
            self.register_buffer("fidelity", auto_encoder.fidelity)

    def _set_params(self, auto_encoder):
        # initialize input / ouput shapes
        encode_input_shape = auto_encoder.input_shape[0]
        encode_output_shape = auto_encoder.config.latent.dim
        decode_input_shape = auto_encoder.config.latent.dim
        decode_output_shape = auto_encoder.input_shape[0]
        forward_input_shape = auto_encoder.input_shape[0]
        forward_output_shape = auto_encoder.input_shape[0]
        # initialize labels
        self.encode_input_labels = ["(signal) channel %s"%(i+1) for i in range(encode_input_shape)]
        self.decode_input_labels = ["(signal) latent dim %s"%(i+1) for i in range(decode_input_shape)]
        self.forward_input_labels = ["(signal) channel %s"%(i+1) for i in range(forward_input_shape)]
        self.encode_output_labels = ["(signal) latent dim %s"%(i+1) for i in range(encode_output_shape)]
        self.decode_output_labels = ["(signal) channel %s"%(i+1) for i in range(decode_output_shape)]
        self.forward_output_labels = ["(signal) channel %s"%(i+1) for i in range(decode_output_shape)]
        self._ordered_tasks = [o['name'] for o in auto_encoder.config.get('conditioning', {'tasks': []})['tasks']]
        self._encoder_ordered_tasks = torch.jit.Attribute([], List[str])
        self._decoder_ordered_tasks = torch.jit.Attribute([], List[str])
        self._forward_ordered_tasks = torch.jit.Attribute([], List[str])
        # check conditionings
        for k in self._ordered_tasks:
            if self.conditionings[k].get('mode', 'cat') == "cat":
                label_dim = self.conditionings[k]['dim']
                targets = checklist(self.conditionings[k].get('target', ['decoder']))
                if isinstance(auto_encoder.concat_embeddings[k], (torch.nn.Embedding, at.OneHot)):
                    task_label = f'(signal) {k} label (0-{label_dim})'
                else:
                    task_label = f'(signal) {k} label (float)'
                if "encoder" in targets:
                    encode_input_shape += 1
                    forward_input_shape += 1
                    self.encode_input_labels.append(task_label)
                    self.forward_input_labels.append(task_label)
                    self._encoder_ordered_tasks.value.append(k)
                    self._forward_ordered_tasks.value.append(k)
                if "decoder" in targets:
                    decode_input_shape += 1
                    self.decode_input_labels.append(task_label)
                    self._decoder_ordered_tasks.value.append(k)
                if k in self.prediction_modules.keys():
                    encode_output_shape += 1
                    self.encode_output_labels.append(task_label)
                    if k not in self._encoder_ordered_tasks.value:
                        forward_output_shape += 1
                        self.forward_output_labels.append(task_label)
                else:
                    if not "encoder" in targets:
                        forward_input_shape += 1
                        self.forward_input_labels.append(task_label)
                        self._forward_ordered_tasks.value.append(k)
            
        # set parameter buffers
        if self._forward_available:
            self.register_buffer("forward_params", torch.tensor([forward_input_shape, 1, forward_output_shape, 1]))
        if self._encode_available:
            self.register_buffer("encode_params", torch.tensor([encode_input_shape, 1, encode_output_shape, self.hop_length]))
        if self._decode_available:
            self.register_buffer("decode_params", torch.tensor([decode_input_shape, self.hop_length, decode_output_shape, 1]))

    def _set_attributes(self, auto_encoder):
        self.register_buffer("inversion_mode_params", torch.tensor([TYPE_HASH[str]]))
        self.register_buffer("temperature_params", torch.tensor([TYPE_HASH[float]]))
        self.register_buffer("dimred_params", torch.tensor([TYPE_HASH[str]]))
        self._attributes: List[str] = ['inversion_mode', 'temperature', 'dimred']
        self.dimred = "none"

    @torch.jit.export
    def get_methods(self):
        return ['encode', 'decode', 'forward']

    @torch.jit.export
    def get_attributes(self):
        return self._attributes

    # helper functions
    def populate_parser(self, parser: ArgumentParser) -> None:
        return

    def get_gain_compensation(self, transform=None):
        if transform is None:
            return 1.
        else:
            return 1 / self.invert(torch.ones(12, self.n_fft)).max()

    # dimensionality reduction methods
    def project_z(self, z:torch.Tensor):
        if self.dimred == "none":
            return z
        z, batch_size = flatten_batch(z, dim=-2)
        z = z - self.latent_mean
        for k, v in self.dimreds.items():
            if k == self.dimred:
                z = v.forward(z)
        z = reshape_batch(z, batch_size, dim=-2)
        return z

    def unproject_z(self, z:torch.Tensor):
        if self.dimred == "none":
            return z
        z, batch_size = flatten_batch(z, dim=-2)
        # z = nn.functional.conv1d(z.transpose(-1,-2), self.latent_dimred.t().unsqueeze(-1)).transpose(-1,-2)
        for k, v in self.dimreds.items():
            if k == self.dimred:
                z = v.invert(z)
        z = z + self.latent_mean
        z = reshape_batch(z, batch_size, dim=-2)
        return z

    # inversion mode
    @torch.jit.export
    def get_inversion_mode(self) -> str:
        for i, t in enumerate(self.transform.transforms):
            if i == self.spectral_transform_idx:
                if hasattr(t, "inversion_mode"):
                    return t.inversion_mode
        return "no inversion mode"
            
        
    @torch.jit.export
    def set_inversion_mode(self, inversion_mode: str) -> int:
        for i, t in enumerate(self.transform.transforms):
            if i == self.spectral_transform_idx:
                if hasattr(t, "inversion_mode"):
                    t.inversion_mode = inversion_mode
                    return 0
        return -1

    # temperature
    @torch.jit.export
    def get_temperature(self) -> float:
        return self.temperature.item()

    @torch.jit.export
    def set_temperature(self, temperature: float) -> int:
        if temperature >= 0:
            self.temperature.fill_(temperature)
            return 0
        else:
            return -1

    # dimensionality reduction
    @torch.jit.export
    def get_dimred(self) -> str:
        return self.dimred

    @torch.jit.export 
    def set_dimred(self, dimred: str) -> int:
        if dimred == "none":
            self.dimred = "none"
        else:
            for k, v in self.dimreds.items():
                if k == dimred:
                    self.dimred = dimred
            if self.dimred != dimred:
                return -1
        return 0

    def transform_label(self, y: torch.Tensor, task: str) -> torch.Tensor:
        for t, embed in self.concat_embeddings.items():
            if t==task: 
                y = embed(y)
        return y 

    def get_dimred_module(self, task: str) -> DimredWrapper:
        for t, embed in self.dimreds.items():
            if t==task:
                return embed
        raise ValueError("embedding for task %s not found"%task)

    def get_prediction_module(self, task: str):
        raise ValueError("prediction module for task %s not found"%task)

    def split_encoder_input(self, x: torch.Tensor) -> Tuple[torch.Tensor, torch.Tensor]:
        splits = (self.input_shape[0], ) + (1,) * (x.size(-2) - self.input_shape[0])
        x_splitted = list(x.split(splits, -2))
        current_id = 1
        for t in self._encoder_ordered_tasks:
            x_splitted[current_id] = self.transform_label(x_splitted[current_id], t).float()
            current_id += 1
        x = x_splitted[0] 
        if len(x_splitted[1:]) == 0:
            y = torch.zeros(0)
        else:
            y = torch.cat(x_splitted[1:], -2)
        return x, y

    def split_decoder_input(self, z: torch.Tensor) -> Tuple[torch.Tensor, torch.Tensor]:
        splits = (self.latent_dim, ) + (1,) * (z.size(-1) - self.latent_dim)
        z_splitted = list(z.split(splits, -1))
        current_id = 1
        for t in self._decoder_ordered_tasks:
            z_splitted[current_id] = self.transform_label(z_splitted[current_id], t).float()
            current_id += 1
        x = z_splitted[0] 
        if len(z_splitted[1:]) == 0:
            y = torch.zeros(0)
        else:
            y = torch.cat(z_splitted[1:], -1)
        return x, y

    def split_forward_input(self, x: torch.Tensor) -> Tuple[torch.Tensor, torch.Tensor]:
        splits = (self.input_shape[0], ) + (1,) * (x.size(-2) - self.input_shape[0])
        x_splitted = list(x.split(splits, -2))
        encoder_input = []
        current_id = 1
        for t in self._forward_ordered_tasks:
            if t in self._encoder_ordered_tasks:
                x_splitted[current_id] = self.transform_label(x_splitted[current_id], t).float()
                encoder_input.append(x_splitted[current_id])
            current_id += 1
        x = x_splitted[0] 
        if len(encoder_input) > 0:
            y = torch.cat(encoder_input, -2)
        else:
            y = torch.tensor(0)
        return x, y

    def get_encoder_input(self, x: torch.Tensor):
        y = torch.tensor(0)
        if len(self._encoder_ordered_tasks) > 0:
            x, y = self.split_encoder_input(x)
        if self.transform is not None:
            x = self.transform(x)
        if len(self._encoder_ordered_tasks) > 0:
            x = torch.cat([x, reshape_cond(y, x)], -2)
        return x
    
    def get_decoder_input(self, z: torch.Tensor) -> torch.Tensor:
        y = torch.tensor(0)
        if len(self._decoder_ordered_tasks) > 0:
            z, y = self.split_decoder_input(z)
        z = self.unproject_z(z)
        if len(self._decoder_ordered_tasks) > 0:
            z = torch.cat([z, y], -1)
        return z

    def get_forward_input(self, x: torch.Tensor):
        y = torch.tensor(0)
        fot: List[str] = self._encoder_ordered_tasks
        if len(fot) > 0:
            x, y = self.split_forward_input(x)
        if self.transform is not None:
            x = self.transform(x)
        if len(fot) > 0:
            x = torch.cat([x, reshape_cond(y, x)], -2)
        return x

    def get_forward_latent(self, x: torch.Tensor, z: torch.Tensor) -> Tuple[torch.Tensor, torch.Tensor]:
        y = torch.tensor(0)
        predicted_y = torch.empty(0)
        predicted_y_list = []
        if self.use_dimred:
            z = self.unproject_z(z)
        if len(self._forward_ordered_tasks) > 0:
            splits = (self.input_shape[0], ) + (1,) * (x.size(-2) - self.input_shape[0])
            x_splitted = list(x.split(splits, -2))
            metadatas = []
            current_id = 1
            for t in self._decoder_ordered_tasks:
                current_meta = torch.zeros(0)
                if t in self._forward_ordered_tasks:
                    current_meta = self.transform_label(x_splitted[current_id][..., 0, :], t)
                    current_id += 1
                elif t in self.prediction_modules:
                    predicted_labels = self.get_prediction(z, t)
                    predicted_y_list.append(predicted_labels)
                    current_meta = self.transform_label(predicted_labels, t)
                metadatas.append(current_meta)
            y = torch.cat(metadatas, -1)
            z = torch.cat([z, y], -1)
            if len(predicted_y) > 0:
                predicted_y = torch.cat(predicted_y_list, -1)
        return z, predicted_y

    def get_prediction(self, z: torch.Tensor, task: str) -> torch.Tensor:
        for t, module in self.prediction_modules.items():
            if t==task:
                probs = module(z).probs
                return probs.argmax(-1).unsqueeze(-1).float()
        raise ValueError("prediction module for task %s not found"%task)

    def get_predictions(self, z: torch.Tensor) -> torch.Tensor:
        predictions = []
        for task, module in self.prediction_modules.items():
            probs = module(z).probs.argmax(-1).unsqueeze(-1).float()
            predictions.append(probs)
        return torch.cat(predictions, -1)

    # main functions
    @torch.jit.export
    def encode(self, x: torch.Tensor, sample: bool = False):
        if self.use_oa:
            x = self.overlap_add(x)
            x_transformed = []
            #TODO Batch transform?
            for i in range(x.size(-2)):
                x_tmp = x[..., i, :]
                x_tmp = self.get_encoder_input(x_tmp)
                x_transformed.append(x_tmp)
            x = torch.stack(x_transformed, dim=-(len(self.encoder.input_shape) + 1))
        else:
            if self.transform is not None:
                x = self.get_encoder_input(x)

        # separate data from conditionings
        z = self.encoder(x)
        out = z.mean + self.temperature * z.stddev
        out = self.project_z(out)
        if len(self.prediction_modules) > 0:
            out = torch.cat([out, self.get_predictions(out)], -1)
        if self.export_for_nn:
            out = out.transpose(-2, -1)
        return out

    @torch.jit.export
    def decode(self, z:torch.Tensor):
        if self.export_for_nn:
            z = z.transpose(-2, -1)
        z = self.get_decoder_input(z)
        x = self.decoder(z)
        if isinstance(x, Distribution):
            x = x.mean
        if self.use_oa:
            outs = []
            iter_dim = -(len(self.encoder.input_shape) + 1)
            for i in range(x.size(iter_dim)):
                x_tmp = x.index_select(-(len(self.encoder.input_shape) + 1), torch.tensor(i)).squeeze(iter_dim)
                if self.transform is not None:
                    x_tmp = self.transform.invert(x_tmp)
                outs.append(x_tmp)
            outs = torch.stack(outs, dim=-2)
            x = self.overlap_add.invert(outs)
        else:
            if self.transform is not None:
                x = self.transform.invert(x)
        return x 

    @torch.jit.export
    def forward(self, x: torch.Tensor, sample: bool = False):
        if self.use_oa:
            x = self.overlap_add(x)
            outs = []
            for i in range(x.size(-2)):
                x_tmp = x[..., i, :]
                x_enc = self.get_forward_input(x_tmp)
                z = self.encoder(x_enc)
                decoder_input = z.mean + self.temperature * z.stddev
                decoder_input, predicted_outs= self.get_forward_latent(x_tmp, decoder_input)
                x_rec = self.decoder(decoder_input)
                if isinstance(x_rec, Distribution):
                    x_rec = x_rec.mean
                if self.transform is not None:
                    x_rec = self.transform.invert(x_rec)
                if predicted_outs.size(0) != 0:
                    x_rec = torch.cat([x_rec, reshape_cond(predicted_outs, x_rec)], -2)
                outs.append(x_rec)
            outs = torch.stack(outs, -2)
            outs = self.overlap_add.invert(outs)
        else:
            if self.transform is not None:
                x = self.transform(x)
            z = self.encoder(x)
            if sample:
                decoder_input = z.sample()
            else:
                decoder_input = z.mean
            outs = self.decoder(decoder_input)
            if isinstance(outs, Distribution):
                outs = outs.mean
            if self.transform is not None:
                outs = self.transform.invert(outs)
        return outs

    # utils
    def _get_spectral_transform(self, transform):
        idx = None
        if isinstance(transform, at.ComposeAudioTransform):
            for i, t in enumerate(transform):
                if isinstance(t, (at.STFT, at.DGT, at.RealtimeSTFT, at.RealtimeDGT)):
                    idx = int(i)
        if idx is None:
            return None
        else:
            return idx
    
    def print_params(self):
        # forward
        print("forward", self.forward_params)
        print('inputs : ')
        for i in self.forward_input_labels:
            print("-", i)
        print("outputs : ")
        for i in self.forward_output_labels:
            print("-", i)
        # encode
        print("encode ", self.encode_params)
        print("inputs : ")
        for i in self.encode_input_labels:
            print("-", i)
        print("outputs : ")
        for i in self.encode_output_labels:
            print("-", i)
        # decode
        print("decode : ", self.decode_params)
        print('inputs : ')
        for i in self.decode_input_labels:
            print("-", i)
        print("outputs : ")
        for i in self.decode_output_labels:
            print("-", i)