import sys
from torch.utils.data import DataLoader
from pytorch_lightning import LightningDataModule
sys.path.append('..')
from acids_transforms import transforms
from . import AudioDataset, augmentations
from ..utils import checklist

def parse_transforms(transform_list):
    if transform_list is None:
        return transforms.AudioTransform()
    transform_list = checklist(transform_list)
    current_transforms = []
    for t in transform_list:
        transform_tmp = getattr(transforms, t['type'])(**t.get('args', {}))
        current_transforms.append(transform_tmp)
    if len(current_transforms) > 1:
        return transforms.ComposeAudioTransform(current_transforms)
    else:
        return current_transforms[0]

def parse_augmentations(augmentation_list):
    if augmentation_list is None:
        return []
    augmentation_list = checklist(augmentation_list)
    current_augmentations = []
    for t in augmentation_list:
        augmentation_tmp = getattr(augmentations, t['type'])(**t.get('args', {}))
        current_augmentations.append(augmentation_tmp)
    return current_augmentations


class AudioDataModule(LightningDataModule):
    def __init__(self, config, **kwargs):
        super().__init__()
        self.dataset = None
        self.dataset_args = dict(config.dataset)
        self.transform_args = config.get('transforms', {})
        self.augmentation_args = config.get('augmentations', [])
        self.loader_args = config.get('loader', {})
        self.partition_balance = config.get('partition_balance', [0.8, 0.2])
        self.dataset = None
        self.train_dataset = None
        self.valid_dataset = None
        self.test_dataset = None
        self.import_datasets()

    def load_dataset(self, dataset_args, transform_args, augmentation_args, make_partitions=False):
        dataset = AudioDataset(config=dataset_args)
        if dataset_args.get('check_folder'):
            dataset.check_audio_folder()
        pre_transforms = transforms.ComposeAudioTransform()
        if transform_args.get('pre_transforms'):
            name = transform_args.get('name')
            if name in dataset.available_transforms and (not transform_args.get('force')):
                pre_transforms = dataset.import_transform(name, n_files=dataset_args.get('n_files'))
            else:
                assert name is not None
                pre_transforms = parse_transforms(transform_args.pre_transforms) or transforms.AudioTransform()
                dataset.transforms = pre_transforms
                dataset.import_data(write_transforms=True, save_transform_as=name,
                                    force=transform_args.get('force', False), min_len=self.dataset_args.get('min_length'))
        else:
            dataset.import_data(min_len=self.dataset_args.get('min_length'), scale=False)
        # flatten data in case
        if dataset_args.get('flatten') is not None:
            dataset.flatten_data(int(dataset_args['flatten']))
        # set transforms
        current_transforms = parse_transforms(transform_args.get('transforms'))
        self.full_transforms = pre_transforms + current_transforms
        dataset.transforms = current_transforms
        # import augmentations
        current_augmentations = parse_augmentations(augmentation_args)
        dataset.augmentations = current_augmentations
        # set partitions
        if make_partitions:
            dataset.make_partitions(['train', 'valid'], self.partition_balance)
        # set sequence export
        if dataset_args.get('sequence'):
            dataset.drop_sequences(dataset_args['sequence'].get('length'),
                                   dataset_args['sequence'].get('idx', -2),
                                   dataset_args['sequence'].get('mode', "random"))
        return dataset

    def import_datasets(self, stage=None):
        # transforms
        self.dataset = self.load_dataset(self.dataset_args, self.transform_args, self.augmentation_args, make_partitions=True)
        self.train_dataset = self.dataset.retrieve('train')
        self.valid_dataset = self.dataset.retrieve('valid')

    @property
    def shape(self):
        return tuple(self.dataset[0][0].shape)

    # return the dataloader for each split
    def train_dataloader(self, batch_size=None, **kwargs):
        loader_args = {**self.loader_args, **kwargs}
        loader_args['batch_size'] = batch_size or loader_args.get('batch_size', 128)
        loader_train = DataLoader(self.train_dataset, **loader_args)
        return loader_train

    def val_dataloader(self, batch_size=None, **kwargs):
        loader_args = {**self.loader_args, **kwargs}
        loader_args['batch_size'] = batch_size or loader_args.get('batch_size', 128)
        loader_args['shuffle'] = False
        loader_val = DataLoader(self.valid_dataset, **loader_args)
        return loader_val

    def test_dataloader(self, batch_size=None, **kwargs):
        if self.test_dataset is None:
            return None
        loader_args = {**self.loader_args, **kwargs}
        loader_args['batch_size'] = batch_size or loader_args.get('batch_size', 128)
        loader_test = DataLoader(self.test_dataset, **loader_args)
        return loader_test

