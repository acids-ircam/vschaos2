import torch, torch.distributions as dist, pdb, random, matplotlib.pyplot as plt, os, numpy as np, re
from typing import Iterable
import torchaudio, tqdm
import dill
import pytorch_lightning as pl
from pytorch_lightning.callbacks import Callback
from pytorch_lightning.trainer.states import RunningStage
from vschaos.utils import checkdir

def check_mono(sgl, normalize=True):
    sgl = sgl.squeeze()
    if sgl.ndim == 2:
        if sgl.shape[0] > 1:
            sgl = sgl.mean(0).unsqueeze(0)
    if normalize:
        sgl /= sgl.max()
    return sgl

def fit_data(data, target_shape, has_batch = True):
    idx_range = range(int(has_batch), len(target_shape))
    for i in idx_range:
        if data.shape[i] > target_shape[i]:
            idx = (slice(None),)*i + (slice(0, target_shape[i]),)
            data = data.__getitem__(idx)
        elif data.shape[i] < target_shape[i]:
            pdb.set_trace()
            pad_shape = tuple(target_shape[:i]) + (target_shape[i] - data.shape[i],) + tuple(target_shape[i+1:])
            data = torch.cat([data, torch.zeros(pad_shape).to(data.device)])
    return data


class AudioReconstructionMonitor(Callback):

    def __init__(self, plot_reconstructions:bool = True, plot_samples: bool = True, has_seq: bool = False,
                 generate_files: bool = True, generate_samples: bool = False, generate_trajs: bool = True,
                 n_reconstructions: int = 5, n_samples: int = 5, n_files: int  = 3, files_path: str = None,
                 temperature_range: Iterable[float]=None, monitor_epochs: int = 1, reconstruction_epochs: int = 5, 
                 sample_reconstruction: bool = False, traj_file: str = None, traj_sr: int = 172, batch_size: int = 256,
                 generate_after_n_epochs: int = 0):
        """
        Callback for audio reconstruction monitoring.
        Args:
            plot_reconstructions (bool): plot audio reconstructions (default: True)
            plot_samples (bool): plot samples from prior (default: True)
            generate_files (bool): generate full audio files (default: True)
            generate_trajs (bool): generate latent trajectories (default: True, needs traj_file defined)
            n_reconstructions (int): number of reconstructions to plot (default: 5)
            n_samples (int): number of samples to plot by temperature values
            n_files (int): number of full files to render (default: 3)
            files_path (int): path to files to reconstruct (optional)
            temperature_range (Iterable[float]): range of temperatures for plotting
            monitor_epochs (int): monitoring period in epoch (default: 1)
            reconstruction_epochs(int): full file generation period in epoch (default: 5)
            sample_reconstruction (int): samples out distribution (default: None)
            traj_file (str): path to trajectory pickle (see github.com/domkkirke/trajectories
            traj_sr (int): trajectory sampling rate (default: 172)
            batch_size (int): batch size for generation (default: 256)
            has_seq(bool): is data sequential (useful for plotting)
        """
        # reconstruction arguments
        self.plot_reconstructions = plot_reconstructions
        self.plot_samples = plot_samples
        self.generate_files = generate_files
        self.n_reconstructions = n_reconstructions
        self.files_path = files_path
        self.generate_trajs = int(generate_trajs or 0)
        self.generate_samples = generate_samples
        self.reconstruction_epochs = reconstruction_epochs
        self.traj_file = traj_file
        self.traj_sr = traj_sr
        self.n_files = n_files
        self.sample_reconstruction = sample_reconstruction
        self.batch_size = batch_size
        self.has_seq = has_seq or False
        # sample arguments
        self.n_samples = n_samples
        self.temperature_range = temperature_range or [0.01, 0.1, 0.5, 1.0, 1.5, 3.0, 5.0, 10.0]
        self.monitor_epochs = monitor_epochs
        self.generate_after_n_epochs = generate_after_n_epochs or 0

    def plot_rec(self, model, loader):
        data = next(loader(batch_size=self.n_reconstructions, num_workers=0).__iter__())
        x_original, x_out = model.reconstruct(data)
        if isinstance(x_original, (tuple, list)):
            x_original, y = x_original
        x_original = x_original.squeeze()
        if len(x_original.shape) == 2:
            fig, ax = plt.subplots(len(x_original), 1)
            for i in range(len(x_original)):
                ax[i].plot(x_original[i], 'b', linewidth=1)
                if isinstance(x_out, dist.Normal):
                    mean = x_out.mean[i].squeeze().cpu(); std = x_out.stddev[i].squeeze().cpu()
                    ax[i].plot(mean, c="g", linewidth=0.7)
                    ax[i].fill_between(np.arange(mean.shape[-1]), mean-std, mean+std, color="g", alpha=0.2)
                else:
                    ax[i].plot(x_out[i].squeeze().cpu())
        elif len(x_original.shape) == 3:
            fig, ax = plt.subplots(len(x_original), 2 * x_original.shape[1], figsize = (10,5))
            for i in range(len(x_original)):
                for j in range(x_original.shape[1]):
                    ax[i, 2 * j].plot(x_original[i][j])
                    if isinstance(x_out, dist.Normal):
                        mean = x_out.mean[i][j].squeeze().cpu()
                        ax[i, 2 * j + 1].plot(mean, linewidth=0.7)
                    else:
                        mean = x_out[i][j].squeeze().cpu()
                        ax[i, 2 * j + 1].plot(x_out[i][j].squeeze().cpu())
        return fig

    def plot_samps(self, model):
        with torch.no_grad():
            out = model.sample_from_prior(n_samples=self.n_samples, temperature=self.temperature_range)
        if isinstance(out, dist.Distribution):
            out = out.mean
        fig, ax = plt.subplots(self.n_samples, len(self.temperature_range))
        for i in range(self.n_samples):
            for j in range(len(self.temperature_range)):
                current_out = out[i, j].squeeze()
                if len(current_out.shape) == 1:
                    ax[i, j].plot(current_out.cpu())
                elif len(current_out.shape) == 2:
                    ax[i, j].imshow(current_out.cpu(), aspect="auto")
                ax[i, j].set(xticklabels=[])
                ax[i, j].set(yticklabels=[])
        return fig, out

    def reconstruct_file(self, model, files, dataset):
        originals = []; generations = []
        for f in files:
            root_directory = self.files_path or dataset.root_directory
            if self.files_path:
                data, meta = dataset.transform_file(f"{root_directory}/{f}")
            else:
                data, meta = dataset.get_data_from_files(f, batch=True)
            if hasattr(model, "input_dim"):
                data = fit_data(data, model.input_dim, has_batch = False)
            # make batch
            try:
                original, generation = model.reconstruct((data, meta))
            except:
                continue
            original = original[0][0].cpu()
            generation = generation[0]
            if isinstance(generation, dist.Normal):
                generation = generation.sample() if self.sample_reconstruction else generation.mean
            generation = generation.cpu()
            originals.append(dataset.invert_transform(original))
            generations.append(dataset.invert_transform(generation))
        if len(originals) == 0:
            print('received empty list of tensors during reconstruction. Abort')
            return None, None
        try:
            originals, generations = torch.cat(originals, -1).squeeze(), torch.cat(generations, -1).squeeze()
        except:
            pdb.set_trace()
        return check_mono(originals, normalize=True), check_mono(generations, normalize=True)

    def generate_trajectories(self, dataset, model, path):
        with open(self.traj_file, 'rb') as f:
            traj_dict = dill.load(f)
        path = re.sub("lightning_logs/", "trajectories/", path)
        checkdir(path)
        phase = np.linspace(0., 1., self.traj_sr)
        for traj_name, traj in tqdm.tqdm(traj_dict.items(), total=len(traj_dict)):
            out = traj(phase)
            out = torch.from_numpy(out)[np.newaxis].float().to(model.device)
            x = model.decode(out)
            if isinstance(x, dist.Distribution):
                x = x.mean
            x = check_mono(dataset.invert_transform(x), normalize=True)
            torchaudio.save(f"{path}/{traj_name}.wav", x, sample_rate = dataset.sr or 44100)
            
    def on_validation_epoch_end(self, trainer: pl.Trainer, pl_module: pl.LightningModule):
        with torch.no_grad():
            if trainer.state.stage == RunningStage.SANITY_CHECKING:
                return
            if trainer.current_epoch % self.monitor_epochs != 0:
                return
            model = trainer.model
            epoch = trainer.current_epoch
            if hasattr(trainer.datamodule, "dataset"):
                dataset = trainer.datamodule.dataset
            else:
                dataset = trainer.datamodule
            # plot and generate reconstructions
            if hasattr(model, 'reconstruct'):
                if self.plot_reconstructions:
                    train_rec = self.plot_rec(model, trainer.datamodule.train_dataloader)
                    trainer.logger.experiment.add_figure('reconstructions/train', train_rec, trainer.current_epoch)
                    valid_rec = self.plot_rec(model, trainer.datamodule.val_dataloader)
                    trainer.logger.experiment.add_figure('reconstructions/valid', valid_rec, trainer.current_epoch)
                    if trainer.datamodule.test_dataset:
                        test_rec = self.plot_rec(model, trainer.datamodule.test_dataloader)
                        trainer.logger.experiment.add_figure('reconstructions/test', test_rec, trainer.current_epoch)
                if self.generate_files and epoch > self.generate_after_n_epochs:
                    if trainer.current_epoch % self.reconstruction_epochs == 0:
                        if dataset is not None:
                            files = random.choices(dataset.files, k=self.n_files)
                            raw_original, raw_generation = self.reconstruct_file(model, files, dataset)
                            if raw_original is not None:
                                trainer.logger.experiment.add_audio('original', raw_original, global_step=trainer.current_epoch, sample_rate=dataset.sr)
                                trainer.logger.experiment.add_audio('generation', raw_generation, global_step=trainer.current_epoch,
                                                                sample_rate=dataset.sr)

            print('prior sampling...')
            # plot prior sampling
            if hasattr(model, 'sample_from_prior') and epoch >= self.generate_after_n_epochs:
                if self.plot_samples:
                    samples, outs = self.plot_samps(model)
                    trainer.logger.experiment.add_figure('samples', samples, trainer.current_epoch)
                    if self.generate_samples:
                        outs = outs.reshape(outs.shape[0]*outs.shape[1], *outs.shape[2:]).cpu()
                        samples_raw = []
                        for sample in outs:
                            samples_raw.append(dataset.invert_transform(sample))
                        samples_raw = torch.cat(samples_raw, -1)
                        if len(samples_raw.shape) == 2:
                            samples_raw = samples_raw[0]
                        trainer.logger.experiment.add_audio('audio_samples', samples_raw, global_step=trainer.current_epoch, sample_rate=dataset.sr)

            print('decode...')
            # generate trajectories
            if hasattr(model, 'decode'):
                if self.generate_trajs and trainer.current_epoch % self.generate_trajs == 0 and epoch >= self.generate_after_n_epochs:
                    if self.traj_file is None or not os.path.isfile(os.path.abspath(self.traj_file)):
                        print('[Warning] trajectory file missing : %s'%self.traj_file)
                    else:
                        self.generate_trajectories(dataset, model, trainer.log_dir)

