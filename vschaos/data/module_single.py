import os, sys, pdb, random, torch
from typing import Type
sys.path.append('..')
from vschaos.data import parse_audio_file, parse_transforms, parse_augmentations, NotInvertibleError
from vschaos.data import transforms
from torch.utils.data import DataLoader, Dataset
from pytorch_lightning import LightningDataModule

class SingleAudioDataset(Dataset):
    def __init__(self, data, metadata, chunk_size, n_batches, sr=44100, bitrate=16, transforms=None, augmentations = []):
        self.chunk_size = chunk_size
        self.n_batches = n_batches
        self.sr = sr
        self.bitrate = bitrate
        self.transforms = transforms
        self.augmentations = augmentations
        self.prepare_data(data, metadata)

    def __len__(self):
        return self.n_batches

    def __getitem__(self, item):
        data, metadata = self.data[item], {"time": self.metadata["time"][item]}
        if self.transforms is not None:
            data = self.transforms(data)
        for aug in self.augmentations:
            data, metadata = aug(data, metadata)
        return data, metadata

    def prepare_data(self, data, metadata):
        idxs = [random.randrange(0, data.shape[-1] - self.chunk_size) for _ in range(self.n_batches)]
        time_offset = metadata.get('time')
        slices = torch.zeros(self.n_batches, self.chunk_size)
        sliced_meta = {'time': torch.zeros(self.n_batches, self.chunk_size)}
        max_time = data.shape[-1] / self.sr
        for i, idx in enumerate(idxs):
            slices[i] = data[:, idx:idx+self.chunk_size]
            sliced_meta['time'][i] = (torch.arange(self.chunk_size) + idx) / (self.sr * 0.5 * max_time) - 1.
        self.data = slices
        self.metadata = sliced_meta


class SingleAudioDataModule(LightningDataModule):
    """A handy data module for regression on a single file"""
    def __init__(self, config, **kwargs):
        self.dataset_args = config.dataset
        self.transform_args = config.get('transforms', {})
        self.augmentation_args = config.get('augmentations', [])
        self.partition_balance = config.get('partition_balance', [0.8, 0.2])
        self.loader_args = config.get('loader', {})

        self.transforms = parse_transforms(self.transform_args.get('transforms')) or transforms.AudioTransform()
        self.augmentations = parse_augmentations(self.augmentation_args)
        self.import_data()

    @property
    def full_time_range(self):
        return torch.arange(self.data.shape[-1]) / self.sr

    @property
    def shape(self):
        return tuple(next(self.train_dataloader(batch_size=1).__iter__())[0].shape[1:])

    def import_data(self):
        self.soundfile = self.dataset_args.path
        self.root_directory = os.path.abspath(os.path.dirname(self.soundfile))
        self.sr = self.dataset_args.get('sr', 44100)
        self.bitrate = self.dataset_args.get('bitrate', 16)
        self.target_length = self.dataset_args.get('target_length')
        self.data, self.metadata = parse_audio_file(self.soundfile, len=self.target_length, sr=self.sr, bitrate=self.bitrate)
        self.files = [self.soundfile]
        if self.data.shape[0] != 1:
            self.data = self.data[0].unsqueeze(0)

    def train_dataloader(self, **kwargs):
        chunk_size = self.dataset_args.get('chunk_size', 1024)
        n_batches = self.dataset_args.get('n_batches', self.data.shape[-1] // chunk_size)
        dataset = SingleAudioDataset(self.data, self.metadata, chunk_size, n_batches, sr=self.sr, bitrate=self.bitrate, transforms=self.transforms, augmentations=self.augmentations)
        loader_args = {**self.loader_args, **kwargs}
        loader_train = DataLoader(dataset, **loader_args)
        return loader_train

    def val_dataloader(self, **kwargs):
        return self.train_dataloader(**kwargs)

    def test_dataloader(self, **kwargs):
        return None
        
    def train_dataset(self, **kwargs):
        chunk_size = self.dataset_args.get('chunk_size', 1024)
        n_batches = self.dataset_args.get('n_batches', self.data.shape[-1] // chunk_size)
        return SingleAudioDataset(self.data, self.metadata, chunk_size, n_batches, sr=self.sr, bitrate=self.bitrate, transforms=self.transforms, augmentations = self.augmentations)

    @property
    def valid_dataset(self):
        return self.train_dataset()
    @property
    def test_dataset(self):
        return None

    def transform_file(self, file):
        data, meta = parse_audio_file(file, self.sr, len=self.target_length, bitrate=self.bitrate)
        data, meta['time'] = self.transforms(data, time=meta['time'])
        return data, meta

    def invert_transform(self, data):
        if self.transforms.invertible:
            inv_data = self.transforms.invert(data)
        else:
            raise NotInvertibleError
        return inv_data

