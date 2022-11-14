import numpy as np, torch, torch.nn as nn
from omegaconf import OmegaConf
from acids_transforms import OneHot
from .. import distributions as dist
from ..models.model import Model, ConfigType
from ..modules import encoders, TimeEmbedding, dimred
from ..utils.misc import checklist, trace_distribution, _recursive_to
from ..losses import get_regularization_loss, get_distortion_loss, priors
from typing import Dict, Union


def dist_select(distrib, idx, dim=0):
    if torch.is_tensor(distrib):
        return distrib.index_select(dim, idx)
    if isinstance(distrib, dist.Normal):
        return dist.Normal(distrib.mean.index_select(dim, idx), distrib.stddev.index_select(dim, idx))
    elif isinstance(distrib, (dist.Bernoulli, dist.Categorical)):
        return type(distrib)(probs=distrib.probs.index_select(dim, idx))
    else:
        raise RuntimeError('dist_select does not handle error : %s'%type(distrib))




class AutoEncoder(Model):
    def __init__(self, config: ConfigType = None, **kwargs):
        """
        Base class for auto-encoding architectures. Configuration file must include:
        - encoder
        - decoder
        - latent
        - training
        - conditioning (optional)

        Args:
            config (Config): full configuration
            **kwargs:
        """
        # manage config
        config = config or OmegaConf.create()
        if isinstance(config, dict):
            config = OmegaConf.create(config)
        config_checkpoint = config.get('config_checkpoint')
        super().__init__(config=config)

        # input config
        self.input_shape = config.get('input_shape') or kwargs.get('input_shape')
        # latent configs
        config.latent = config.get('latent')
        self.latent = config.latent

        # conditioning parameters
        concat_embeddings = {}
        self.conditionings = {}
        if config.get('conditioning') is not None:
            decoder_cat_conds = {}
            for task_name, task_config in config.conditioning.items():
                config.conditioning[task_name]['target'] = checklist(config.conditioning[task_name].get('target', ['decoder']))
                config.conditioning[task_name]['mode'] = config.conditioning[task_name].get('mode', 'cat')
                embedding_type = task_config.get('embedding', "OneHot")
                if (embedding_type == "OneHot"):
                    concat_embeddings[task_name] = OneHot(n_classes=task_config['dim'])
                    if "decoder" in task_config['target']:
                        decoder_cat_conds[task_name] = task_config['dim']
                elif (embedding_type == "Embedding"):
                    concat_embeddings[task_name] = nn.Embedding(task_config['dim'], task_config.get('out_dim', 16), **task_config.get('args', {}))
                    if "decoder" in task_config['target']:
                        decoder_cat_conds[task_name] = task_config['dim']
                elif (embedding_type == "TimeEmbedding"):
                    concat_embeddings[task_name] = TimeEmbedding(task_config['dim'], **task_config.get('args', {}))
                    if "decoder" in task_config['target']:
                        decoder_cat_conds[task_config['name']] = 1
                self.conditionings[task_name] = task_config
        self.concat_embeddings = nn.ModuleDict(concat_embeddings)

        # prediction parameters
        if config.get('prediction'):# and len(decoder_cat_conds) > 0:
            prediction_modules = {}
            for pred_task, pred_config in config.prediction.items():
                prediction_module_type = getattr(encoders, pred_config.get('type', 'MLPEncoder'))
                pred_config.args = pred_config.get('args', {})
                pred_config.args.input_shape = config.latent.dim
                pred_config.args.target_shape = pred_config['dim']
                prediction_modules[pred_task] = prediction_module_type(pred_config.get('args',{}))
            self.prediction_modules = nn.ModuleDict(prediction_modules)
            
        # encoder architecture
        config.encoder = config.get('encoder')
        config.encoder.args = config.encoder.get('args', {})
        if config.encoder['args'].get('input_shape') is None:
            config.encoder['args']['input_shape'] = self.get_encoder_shape(self.input_shape)
        if config.encoder['args'].get('target_shape') is None:
            config.encoder['args']['target_shape'] = config.latent.dim
        config.encoder['args']['target_dist'] = config.latent.dist
        encoder_type = config.encoder.type or "MLPEncoder"
        self.encoder = getattr(encoders, encoder_type)(config.encoder.args)

        # decoder architecture
        config.decoder = config.get('decoder')
        config.decoder.args = config.decoder.get('args', {})
        config.decoder.args.input_shape = self.get_decoder_shape(config.latent.dim)
        if config.decoder.args.get('input_shape') is None:
            config.decoder.args.input_shape = config.latent.dim
        if config.decoder.args.get('target_shape') is None:
            config.decoder.args.target_shape = self.input_shape
        decoder_type = config.decoder.type or "MLPDecoder"
        self.decoder = getattr(encoders, decoder_type)(config.decoder.args)

        # loss
        config.training = config.get('training')
        rec_config = config.training.get('reconstruction', OmegaConf.create())
        self.reconstruction_loss = get_distortion_loss(rec_config)
        reg_config = config.training.get('regularization', OmegaConf.create())
        self.regularization_loss = get_regularization_loss(reg_config)
        self.prior = getattr(priors, config.training.get('prior', "isotropic_gaussian"))

        # dimensionality reduction
        self._latent_buffer = []
        self.register_buffer("latent_mean", torch.zeros(config.latent.dim))
        dim_red_types = config.get('dim_red', ["PCA", "ICA"])
        self.dimred_batches = config.get('dim_red_batches', 1024)
        self.dimreds = nn.ModuleDict({k:  getattr(dimred, k)(config.latent.dim) for k in dim_red_types})

        # load from checkpoint
        if config_checkpoint:
            self.import_checkpoint(config_checkpoint)
        # record configs
        self.save_config(self.config)

    def get_encoder_shape(self, input_shape):
        if self.config.get('conditioning') is None:
            return input_shape
        concat_dims = []
        for t in self.config.conditioning.values():
            if "encoder" in t.get('target'):
                embedding_type = t.get('embedding', "OneHot")
                if (embedding_type == "OneHot") or (embedding_type == "TimeEmbedding") :
                    concat_dims.append(t['dim'])
                elif (embedding_type == "Embedding"):
                    concat_dims.append(t['out_dim'])
        if len(input_shape) == 1:
            input_shape = (input_shape[0] + int(np.sum(concat_dims)), )
        else:
            input_shape = (input_shape[0] + int(np.sum(concat_dims)), *input_shape[1:])
        return input_shape
        
    def get_decoder_shape(self, latent_dim):
        if self.config.get('conditioning') is None:
            return latent_dim
        concat_dims = []
        for t in self.config.conditioning.values():
            if "decoder" in t.get('target'):
                embedding_type = t.get('embedding', "OneHot")
                if (embedding_type == "OneHot") or (embedding_type == "TimeEmbedding") :
                    concat_dims.append(t['dim'])
                elif (embedding_type == "Embedding"):
                    concat_dims.append(t['out_dim'])
        if isinstance(latent_dim, (list, tuple)):
            if len(latent_dim) == 1:
                latent_dim = (latent_dim[0] + int(np.sum(concat_dims)), )
            else:
                latent_dim = (latent_dim[0] + int(np.sum(concat_dims)), *latent_dim[1:])
        else:
            latent_dim = latent_dim + int(np.sum(concat_dims))
        return latent_dim

    def configure_optimizers(self):
        optimizer_config = self.config.training.get('optimizer', {'type':'Adam'})
        optimizer_args = optimizer_config.get('args', {'lr':1e-4})
        parameters = self.get_parameters(self.config.training.get('optim_params'))
        optimizer = getattr(torch.optim, optimizer_config['type'])(parameters, **optimizer_args)
        if self.config.training.get('scheduler'):
            scheduler_config = self.config.training.get('scheduler')
            scheduler_args = scheduler_config.get('args', {})
            scheduler = getattr(torch.optim.lr_scheduler, scheduler_config.type)(optimizer, **scheduler_args)
            return {"optimizer": optimizer, "lr_scheduler": scheduler, "monitor": "loss/valid"}
        else:
            return optimizer

    def get_beta(self):
        beta = self.config.training.beta if self.config.training.beta is not None else 1.0
        if self.config.training.warmup:
            beta_schedule_type = self.config.training.get('beta_schedule_type', "epoch")
            if beta_schedule_type == "epoch":
                beta = min(int(self.trainer.current_epoch) / self.config.training.warmup, beta)
            elif beta_schedule_type == "batch":
                beta = min(int(self.trainer.global_step) / self.config.training.warmup, beta)
        return beta

    # External methods
    def forward(self, x: torch.Tensor, *args, **kwargs) -> torch.Tensor:
        # in lightning, forward defines the prediction/inference actions
        return self.encode(x, *args, **kwargs)

    def encode(self, x: torch.Tensor) -> torch.Tensor:
        return self.encoder(x)

    def sample(self, z_params: Union[dist.Distribution, torch.Tensor]) -> torch.Tensor:
        """Samples a latent distribution."""
        if isinstance(z_params, dist.Distribution):
            z = z_params.rsample()
        else:
            z = z_params
        return z

    def decode(self, z: torch.Tensor):
        """Decode an incoming tensor."""
        return self.decoder(z)

    def predict(self, z: torch.Tensor, y: Dict[str, torch.Tensor] = None):
        if not hasattr(self, "prediction_modules"):
            return {}, None
        y_params = {}
        y_out = dict(y)
        for task_name, predictor in self.prediction_modules.items():
            prediction_out = predictor(z)
            y_params[task_name] = prediction_out
            if isinstance(prediction_out, dist.Distribution):
                y_out[task_name] = prediction_out.sample()
            else:
                y_out[task_name] = prediction_out
        return y_params, y_out

    def reinforce(self, x, z, mode="forward"):
        """callback used for adversarial reinforcement"""
        if mode == "forward":
            return self.reconstruct(x)[1]
        elif mode == "latent":
            return self.decode(z)

    def get_encoder_input(self, x: torch.Tensor, y: Dict[str, torch.Tensor]=None):
        for k, v in self.concat_embeddings.items():
            if "encoder" in self.conditionings[k].target:
                assert y is not None, "model is conditioned; please explicit conditioning with the y keyword"
                assert y.get(k) is not None, "missing information for task %s"%k
                n_classes = self.conditionings[k]['dim']
                cond = torch.where(y[k].isnan(), torch.randint_like(y[k], 0, n_classes), y[k])
                cond = v(cond.long())
                if len(self.input_shape) == 1:
                    x = torch.cat([x, cond], 0)
                else:
                    extra_dims = torch.Size([1]*(len(self.input_shape) - 1))
                    cond = cond.view(cond.shape + extra_dims)
                    cond = cond.expand(*cond.shape[:-len(extra_dims)], *x.shape[-len(extra_dims):])
                    x = torch.cat([x, cond], dim=-(len(self.input_shape)))
        return x

    def get_decoder_input(self, z: torch.Tensor, y: Dict[str, torch.Tensor]=None):
        for k, v in self.concat_embeddings.items():
            if "decoder" in self.conditionings[k].target:
                assert y is not None, "model is conditioned; please explicit conditioning with the y keyword"
                assert y.get(k) is not None, "missing information for task %s"%k
                n_classes = self.conditionings[k]['dim']
                cond = torch.where(y[k].isnan(), torch.randint_like(y[k], 0, n_classes), y[k])                
                cond = v(cond.long())
                if len(self.decoder.input_shape) == 1:
                    z = torch.cat([z, cond], -1)
                else:
                    extra_dims = torch.Size([1]*(len(self.input_shape) - 1))
                    cond = cond.view(cond.shape + extra_dims)
                    cond = cond.expand(*cond.shape[:-len(extra_dims)], *z.shape[-len(extra_dims):])
                    z = torch.cat([z, cond], dim=-(len(self.input_shape)))
        return z

    @torch.jit.export
    def full_forward(self, x: torch.Tensor, batch_idx: int=None,  sample: bool=True, use_predictions = True) -> Dict:
        """encodes and decodes an incoming tensor."""
        if isinstance(x, (tuple, list)):
            x, y = x

        else:
            x, y = x, None
        # encoding
        encoder_input = self.get_encoder_input(x, y=y)
        z_params = self.encoder(encoder_input)
        # sampling
        if sample:
            z = self.sample(z_params)
        else:
            z = z_params.mean
        y_pred_params, y_pred = self.predict(z=z, y=y)
        # decoding
        if use_predictions and y_pred is not None:
            decoder_input = self.get_decoder_input(z, y=y_pred)
        else:
            decoder_input = self.get_decoder_input(z, y=y)
        x_hat = self.decoder(decoder_input)
        return x_hat, z_params, z, y_pred_params, y_pred

    def loss(self, batch, x, z_params, z, y_params = None, drop_detail = False, **kwargs):
        if isinstance(batch, (tuple, list)):
            batch, y = batch
        else:
            batch, y = batch, None
        # reconstruction losses
        rec_loss = self.reconstruction_loss(x, batch, drop_detail=drop_detail)
        # regularization losses
        prior = self.prior(z.shape, device=batch.device)
        reg_loss = self.regularization_loss(prior, z_params, drop_detail=drop_detail)
        if drop_detail:
            rec_loss, rec_losses = rec_loss
            rec_losses['rec_loss'] = rec_loss.detach().cpu().item()
            reg_loss, reg_losses = reg_loss
            rec_losses['reg_loss'] = rec_loss.detach().cpu().item()
        # classic ELBO
        beta = self.get_beta()
        loss = rec_loss + beta * reg_loss
        # classification losses for semi-supervised learning
        classif_losses = {}
        if y is not None:
            if y_params is not None:
                for t, p in y_params.items():
                    # if not p.get('predict', False):
                    #     continue
                    # classif_losses[f"{t}_entropy"] = - p.entropy().mean(0).sum()
                    unsup_idx = torch.where(y[t].isnan())[0]
                    sup_idx = torch.where(torch.logical_not(y[t].isnan()))[0]
                    if len(unsup_idx) > 0:
                        unsup_loss = dist_select(p, unsup_idx).entropy().mean(0).sum()
                        classif_losses[f"{t}_entropy"] = unsup_loss.detach().cpu().item()
                        loss = loss - self.config.prediction[t].get('weight', 1.0) * unsup_loss
                    if len(sup_idx) > 0:
                        sup_params = dist_select(p, sup_idx)
                        sup_labels = y[t].index_select(-1, sup_idx)
                        sup_loss = - sup_params.log_prob(sup_labels).mean(0).sum()
                        loss = loss - self.config.prediction[t].get('weight', 1.0) * sup_loss
                        classif_losses[f"{t}_logdensity"] = sup_loss.detach().cpu().item()

                    #     classif_losses[f"{t}_crossentropy"] =  - p.log_prob(y[t]).mean(0).sum()
                    #     loss = loss + self.conditionings[t].get('weight', 1.0) * classif_losses[f"{t}_crossentropy"]
                    # else:
                    #     loss = loss + self.conditionings[t].get('weight', 1.0) * classif_losses[f"{t}_entropy"]
        if drop_detail:
            return loss, {"full_loss": loss.cpu().detach(), **classif_losses, **reg_losses, **rec_losses}
        else:
            return loss

    def _update_latent_buffer(self, z_params):
        if isinstance(z_params, dist.Normal):
            z_params = z_params.mean
        if len(self._latent_buffer) <= self.dimred_batches:
            self._latent_buffer.append(z_params.detach().cpu())

    def on_train_epoch_end(self):
        # shamelessly taken from Caillon's RAVE
        latent_pos = torch.cat(self._latent_buffer, 0).reshape(-1, self.config.latent.dim)
        self.update_dimreds(latent_pos)

    def training_step(self, batch, batch_idx):
        # training_step defined the train loop.
        x, z_params, z, y_params, y = self.full_forward(batch, batch_idx, use_predictions=False)
        loss, losses = self.loss(batch, x, z_params, z, y_params=y_params, epoch=self.trainer.current_epoch, drop_detail=True)
        losses['beta'] = self.get_beta()
        self.log_losses(losses, "train", prog_bar=True)
        self._update_latent_buffer(z_params)
        return loss

    def validation_step(self, batch, batch_idx):
        x, z_params, z, y_params, y = self.full_forward(batch, batch_idx, use_predictions=True)
        loss, losses = self.loss(batch, x, z_params, z, y_params=y_params, drop_detail=True)
        self.log_losses(losses, "valid", prog_bar=True)
        return loss

    def update_dimreds(self, latent_pos):
        for dimred in self.dimreds.values():
            dimred.fit(latent_pos)
        self._latent_buffer = []

    def trace(self, x: torch.Tensor, sample: bool = False, use_predictions: bool = False):
        trace_model = {'encoder': {}, 'decoder' : {}}
        if isinstance(x, (tuple, list)):
            x, y = x
        x = self.get_encoder_input(x, y=y)
        z_params = self.encoder(x, trace = trace_model['encoder'])
        if sample:
            z = self.sample(z_params)
        else:
            z = z_params.mean
        y_pred_params, y_pred = self.predict(z=z, y=y)
        if use_predictions and y_pred is not None:
            decoder_input = self.get_decoder_input(z, y=y_pred)
        else:
            decoder_input = self.get_decoder_input(z, y=y)
        x_params = self.decoder(decoder_input, trace = trace_model['decoder'])
        trace = {}
        trace['embeddings'] = {'latent': {'data': z_params.mean, 'metadata': y}, **trace.get('embeddings', {})}
        trace['histograms'] = {**trace.get('histograms', {}),
                               **trace_distribution(z_params, name="latent", scatter_dim=True),
                               **trace_distribution(x_params, name="out"),
                               **trace_model}
        if y_pred_params is not None:
            for t in y_pred_params:
                trace['histograms'][f'pred_{t}'] = y_pred_params[t].sample()
        return trace

    def reconstruct(self, x, *args, sample_latent=False, sample_data=False, **kwargs):
        x_out, _, _, _, _ = self.full_forward(_recursive_to(x, self.device), sample=sample_latent)
        if isinstance(x_out, dist.Distribution):
            if sample_data:
                x_out = x_out.sample()
            else:
                x_out = x_out.mean
        return x, x_out

    def sample_from_prior(self, n_samples=1, temperature=1.0, sample=False):
        temperature = checklist(temperature)
        generations = []
        y = {}
        if self.conditionings is not None:
            decoder_task = list(filter(lambda x: "decoder" in self.conditionings[x]['target'], self.concat_embeddings.keys()))
            if len(decoder_task) > 0:
                for t in decoder_task:
                    y[t] = torch.randint(0, self.conditionings[t]['dim'], (n_samples,), device=self.device)
        for t in temperature:
            z = torch.randn((n_samples, self.latent.dim), device=self.device) * t
            decoder_input = self.get_decoder_input(z, y)
            x = self.decode(decoder_input)
            if not torch.is_tensor(x):
                if sample:
                    x = x.sample()
                else:
                    x = x.mean
            generations.append(x)
        return torch.stack(generations, 1)


