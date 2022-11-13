import sys, pdb, random
from tqdm import tqdm
sys.path.append('..')
from acids_transforms.transforms import AudioTransform, NotInvertibleError
from vschaos.data.augmentations import AudioAugmentation
from vschaos.data import metadata as am
from vschaos.utils import *
import torch, torchaudio, os, dill, re, numpy as np, matplotlib.pyplot as plt, random, copy, lardon, numbers, math
from tqdm import tqdm
from torch.utils.data import Dataset, BatchSampler
from torch.nn.utils import rnn
from typing import Union, Iterable, Tuple
from omegaconf import OmegaConf

def parse_audio_file(f, sr=None, len=None, min_len=None, bitrate=None):
    x, f_sr = torchaudio.load(f)
    if f_sr != sr and sr is not None:
        x = torchaudio.transforms.Resample(f_sr, sr)(x)
    else:
        sr = f_sr
    if len is not None:
        if isinstance(len, float):
            len = int(len * sr)
        if len < x.shape[-1]:
            x = x[..., :len]
        else:
            pad = torch.zeros((*x.shape[:-1], len - x.shape[-1]), device=x.device, dtype=x.dtype)
            x = torch.cat([x, pad], dim=-1)
    if min_len is not None:
        if x.shape[-1] < min_len:
            pad = torch.zeros((*x.shape[:-1], min_len - x.shape[-1]), device=x.device, dtype=x.dtype)
            x = torch.cat([x, pad], dim=-1)
    if bitrate is not None:
        current_bitrate = torchaudio.info(f).bits_per_sample
        if current_bitrate != bitrate:
            x = torchaudio.functional.apply_codec(x, sr, format="wav", bits_per_sample=16)
    return x, {'time':torch.Tensor([0.0]), 'sr':sr or f_sr}

def parse_folder(d, valid_exts):
    files = []
    for root, directory, files in os.walk(d):
        valid_files = filter(lambda x: os.path.splitext(x)[1] in valid_exts, files)
        valid_files = [root+'/'+f for f in valid_files]
        files.extend(valid_files)
    return files

type_hash = {"int":int, "str": str, "float": float}
def get_callback_from_config(config):
    callback_name = config.get('name', 'read_metadata')
    callback_type = type_hash[config.get('type', 'int')]
    return getattr(am, callback_name)(callback_type)

def import_classes(f):
    classes = {}
    with open(f, 'r') as f:
        for line in f.readlines():
            idx, cl = line.split('\t')
            classes[cl[:-1]] = int(idx)
    classes['_length'] = len(classes.keys())
    return classes

def collate_out(data, pack=False):
    if isinstance(data[0], (list, tuple)):
        return [collate_out(list(d)) for d in zip(*data)]
    lengths = [0 if len(d.shape) == 0 else d.shape[0] for d in data]
    if isinstance(data[0], np.ndarray):
        data = [torch.from_numpy(d) for d in data]
    elif not hasattr(data[0], "__iter__"):
        data = [torch.Tensor([d]) for d in data]
    if len(set(lengths)) == 1:
        data = torch.stack(data)
    else:
        if pack:
            data = rnn.pack_padded_sequence(rnn.pad_sequence(data, batch_first=True), lengths,
                                            batch_first=True, enforce_sorted=False)
        else:
            data = rnn.pad_sequence(data, batch_first=True)
    return data

def getdtype(dtype_string):
    if dtype_string is None:
        return None
    try:
        dtype = getattr(torch, dtype_string)
        return dtype
    except AttributeError:
        return None


class AudioDataset(Dataset):
    """Returns a dataset suitable for machine learning processing in PyTorch.
    It allows to run the main quality-check routines.
    """
    types = ['.aif', '.wav', '.aiff', '.mp3']

    def _settransform(self, transforms):
        assert isinstance(transforms, AudioTransform)
        self._transforms = transforms
        if transforms.needs_scaling and len(self.data) > 0:
            self.scale_transform(self.scale_amount)
        if transforms.scriptable:
            try:
                transforms = torch.jit.script(transforms)
            except Exception as e:
                print("Error occurred when scripting audio transorm : %s"%e)
    def _gettransform(self):
        return self._transforms
    def _deltransform(self):
        self._transforms = AudioTransform()
    transforms = property(_gettransform, _settransform, _deltransform)

    def _setaugmentation(self, augmentations):
        augmentations = checklist(augmentations)
        assert len(list(filter(lambda x: not isinstance(x, AudioAugmentation), augmentations))) == 0
        for a in augmentations:
            if self.sr is not None:
                a.sr = self.sr
            if self.bitrate is not None:
                a.bitrate = self.bitrate
        self._augmentations = augmentations
        self.augment = True
    def _getaugmentation(self):
        return self._augmentations
    def _delaugmentation(self):
        self.augmentations = []
    augmentations = property(_getaugmentation, _setaugmentation, _delaugmentation)


    def __init__(self, config: OmegaConf = None, root: str=None, sr: int=44100, bitrate:int=16, dtype: torch.dtype=None,
                 target_length: Union[float, int]=None, transforms: AudioTransform = AudioTransform(),
                 augmentations: AudioAugmentation=[], target_transforms = None,
                 sequence: Union[OmegaConf, dict] = None, scale_amount=10):
        """
        General dataset for audio data. Imports audio files as raw waveforms, and may transform it using audio transforms
        using the lardon (memmap front-end) encoding.

        Args:
            root (str): dataset root. Raw data must be in subfolder "data/", and transforms in subfolder "transforms/"
            sr (int): sampling rate (default: None, does not convert incoming files)
            bitrate (int): bitrate (default: 16)
            dtype (torch.dtype): default dtype used (default: default torch dtype)
            target_length (int, float): enforces data length during import (default: None)
            transforms (AudioTransform): audio transform used when dataset is indexed.
            target_transforms (AudioTransform): metadata transform used when dataset is indexed.
            augmentations (AudioAugmentation): augmentations performed when dataset is indexed.
            scale_amount (int): amount of data items used for transform scaling (default: 10)
        """
        if config is None:
            config = OmegaConf.create()
        self.root_directory = config.get('root') or root
        assert self.root_directory is not None, "root must be present in config or in keyword root"
        if not os.path.isdir(self.root_directory):
            raise FileNotFoundError(root)
        self.target_length = config.get('target_length') or target_length
        self.data = []
        self.metadata = {}
        self.classes = {}
        self.sr = config.get('sr') or sr or 44100
        assert sr is not None
        self.bitrate = config.get('bitrate') or bitrate or 16
        self.dtype = getdtype(config.get('dtype')) or dtype or torch.get_default_dtype()
        self.partitions = {}
        self.partition_files = None
        self.parse_files()

        # data attributes
        self._pre_transform = AudioTransform()
        self.transforms = transforms or AudioTransform()
        self.augmentations = augmentations
        self.augment = len(self.augmentations) > 0
        self.scale_amount = config.get('scale_amount') or scale_amount
        self._flattened = None
        # metadata attributes
        self.target_transforms = target_transforms
        self.metadata_callbacks = config.get('metadata_callbacks', {})
        # sequence attributes
        sequence = config.get('sequence', sequence)
        self._sequence_mode = None if sequence is None else sequence.get('mode', 'random')
        self._sequence_length = None if sequence is None else sequence.get('length', 1)
        self._sequence_dim = -2 if sequence is None else sequence.get('dim', -2)

    @property
    def available_transforms(self):
        transform_dir = f"{self.root_directory}/transforms"
        if not os.path.isdir(transform_dir):
            return []
        transforms = os.listdir(transform_dir)
        available_transforms = []
        for d in transforms:
            current_dir = f"{transform_dir}/{d}"
            if d != "raw":
                if not os.path.isdir(current_dir):
                    continue
                if not os.path.isfile(current_dir+"/parsing.ldn"):
                    continue
            available_transforms.append(d)
        return available_transforms

    def __len__(self):
        return len(self.data)

    def __getitem__(self, item: Union[slice, Iterable[int], int], augment=True, **kwargs):
        # retrieve indices
        if isinstance(item, slice):
            item = list(range(len(self)))[item]
        # retrieve data
        if hasattr(item, "__iter__"):
            data = [self.get_item(i, **kwargs) for i in item]
            data, seq_idx = [d[0] for d in data], [d[1] for d in data]
        else:
            data, seq_idx = self.get_item(item, **kwargs)
        data = checktensor(data)
        # retrieve metadata
        metadata = self._get_item_metadata(item, seq=seq_idx)
        # transform data
        if self._transforms is not None:
            data = self._transforms.forward_with_time(data, time=metadata.get('time'))
            if metadata.get('time') is not None:
                data, metadata['time'] = data
        # augment data
        if len(self.augmentations) > 0 and augment:
            for a in self.augmentations:
                data, metadata = a(data, y=metadata)
        # collate data
        if isinstance(data, list):
            try:
                data = collate_out(data)
                if data.dtype != self.dtype and self.dtype is not None:
                    data = data.to(self.dtype)
            except RuntimeError:
                print('[Warning] Data could not be stacked with indexes %s'%item)
        else:
            data = data.to(self.dtype)
        return data, metadata


    def get_item(self, item: int, sequence_mode: int = None, sequence_length: int = None,
                 sequence_dim: int = None) -> Tuple[torch.Tensor, int]:
        """
        Get item at a given position. Additional sequence parameters can be given to override default dataset
        parameters.
        Args:
            item (int): item to load
            sequence_mode (int): sequence mode ("random"|"start", default: "random")
            sequence_length:
            sequence_dim:

        Returns:

        """

        sequence_mode = sequence_mode or self._sequence_mode
        sequence_length = sequence_length or self._sequence_length
        sequence_dim = sequence_dim or self._sequence_dim or 0
        # importing data
        seq_idx = 0
        if isinstance(self.data, list):
            idx = [slice(None)] * len(self.data[item].shape)
            is_asynchronous = isinstance(self.data[item], lardon.OfflineDataList)
            if sequence_length is not None:
                if sequence_mode == "random":
                    if is_asynchronous:
                        idx[sequence_dim] = lardon.randslice(sequence_length)
                    else:
                        if self.data[item].shape[sequence_dim] <= sequence_length:
                            seq_idx = 0
                        else:
                            seq_idx = random.randrange(0, self.data[item].shape[sequence_dim] - sequence_length)
                        idx[sequence_dim] = slice(seq_idx, seq_idx + sequence_length)
                elif sequence_mode == "start":
                    idx[sequence_dim] = slice(0, sequence_length)
                else:
                    raise ValueError("sequence mode %s not known"%sequence_mode)
            if is_asynchronous:
                data, meta = self.data[item].__getitem__(tuple(idx), return_metadata=True, return_indices=True)
                seq_idx = meta['idx']
            else:
                data = self.data[item].__getitem__(tuple(idx))
        else:
            if self.data.ndim is None:
                ndim = len(self.data.entries[item].shape)
            else:
                ndim = self.data.ndim - 1
            idx = [item] + [slice(None)] * (ndim)
            is_asynchronous = isinstance(self.data, lardon.OfflineDataList)
            if sequence_length is not None:
                if sequence_mode == "random":
                    if is_asynchronous:
                        idx[sequence_dim] = lardon.randslice(sequence_length)
                    else:
                        seq_idx = random.randrange(0, self.data[item].shape[sequence_dim] - sequence_length)
                        idx[sequence_dim] = slice(seq_idx, seq_idx + sequence_length)
                elif sequence_mode == "start":
                    idx[sequence_dim] = slice(0, sequence_length)
                else:
                    raise ValueError("sequence mode %s not known"%sequence_mode)
            if is_asynchronous:
                data, meta = self.data.__getitem__(tuple(idx), return_metadata=True, return_indices=True)
            else:
                data = self.data.__getitem__(idx)
        return data, seq_idx

    def _get_time(self, metadata, seq):
        metadata = checktensor(metadata, allow_0d=False)
        if seq > 0 and metadata.ndim == 1:
            return metadata + seq / self.sr
        elif metadata.ndim == 0:
            return torch.Tensor([metadata])
        else:
            return metadata[seq]

    def _get_item_metadata(self, item: int, seq: int=None):
        if hasattr(item, "__iter__"):
            metadatas = [self._get_item_metadata(item[i], seq[i]) for i in range(len(item))]
            compiled_metadata = {}
            for k in metadatas[0].keys():
                try:
                    compiled_metadata[k] = torch.stack([m[k] for m in metadatas])
                except:
                    compiled_metadata[k] = [m[k] for m in metadatas]
            return compiled_metadata
        seq = seq if seq is not None else slice(None)
        if hasattr(seq, "__iter__"):
            metadata = {'time': checktensor([self._get_time(self.metadata['time'][item], s) for s in seq], allow_0d=False)}
        else:
            metadata = {'time': checktensor(self._get_time(self.metadata['time'][item], seq), allow_0d=False)}
        for k in self.metadata.keys():
            if k == "time":
                continue
            current_meta = self.metadata[k][item]
            if isinstance(current_meta, ContinuousList):
                current_meta = current_meta[metadata['time']]
            elif hasattr(current_meta, '__iter__'):
                current_meta = current_meta[seq]
            if isinstance(current_meta, (int, np.int, np.int32, np.int64)):
                metadata[k] = torch.tensor(current_meta, dtype=torch.long)
            elif isinstance(current_meta, (float, np.float, np.float32, np.float64)):
                metadata[k] = torch.tensor(current_meta)
            else:
                metadata[k] = current_meta
        return metadata

    def make_partitions(self, names: Iterable[str], balance: Iterable[float], from_files: bool=True) -> None:
        """
        Builds partitions from the data
        Args:
            names (list[str]) : list of partition names
            balance (list[float]) : list of partition balances (must sum to 1)
            from_files (bool): build partition over files rather than data items (ensures consistency with flattened data)
        """
        partition_files = {}
        if from_files:
            files = list(self.hash.keys())
            permutation = np.random.permutation(len(files))
            cum_ids = np.cumsum([0] + [int(n * len(files)) for n in balance])
            partitions = {}
            partition_files = {}
            for i, n in enumerate(names):
                partition_files[n] = [files[f] for f in permutation[cum_ids[i]:cum_ids[i + 1]]]
                partitions[n] = sum([checklist(self.hash[f]) for f in partition_files[n]], [])
        else:
            permutation = np.random.permutation(len(self.data))
            cum_ids = np.cumsum([0]+[int(n*len(self.data)) for n in balance])
            partitions = {}
            for i, n in enumerate(names):
                partitions[n] = permutation[cum_ids[i]:cum_ids[i+1]]
                partition_files[n] = [self.files[n] for n in permutation[cum_ids[i]:cum_ids[i+1]]]
        self.partitions = partitions
        self.partition_files = partition_files

    def drop_sequences(self, sequence_length, sequence_dim=0, sequence_mode="random") -> None:
        """
        Tells the dataset to drop data sequences.
        Args:
            sequence_length (int): length of sequences
            sequence_dim (int): sequence axis (default: 0)
            sequence_mode (int): "random" takes a random chunk, "start" takes the sequence at the beginning. (default: 0)

        """
        if sequence_length is None:
            self._sequence_length = None
            self._sequence_mode = None
            self._sequence_dim = sequence_dim
        else:
            self._sequence_length = sequence_length
            self._sequence_mode = sequence_mode
            self._sequence_dim = sequence_dim

    def retrieve(self, item: Union[int, torch.LongTensor, Iterable[int], str]) -> Dataset:
        """
        Returns an AudioDataset with a subset of selected items.
        Args:
            item (int, Iterable[int], torch.LongTensor or str) : target data ids / partition

        Returns:
            subdataset (AudioDataset) : obtained sub-dataset
        """
        if isinstance(item, list):
            item = np.array(item)
        elif isinstance(item, torch.LongTensor):
            item = item.detach().numpy()
        elif isinstance(item, int):
            item = np.array([item])
        elif isinstance(item, str):
            item = self.partitions[item]

        dataset = type(self)(root=self.root_directory, sr = self.sr, target_length=self.target_length,
                             bitrate=self.bitrate, dtype=self.dtype, 
                             transforms=self._transforms, augmentations=self._augmentations)

        if isinstance(self.data, lardon.OfflineDataList):
            dataset.data = lardon.OfflineDataList([self.data.entries[d] for d in item])
        else:
            dataset.data = [self.data[d] for d in item]
        dataset.metadata = {k: (np.array(v)[item]) for k, v in self.metadata.items()}
        dataset.files = [self.files[f] for f in item]
        dataset.hash = {}
        for i, f in enumerate(dataset.files):
            dataset.hash[f] = dataset.hash.get(f, []) + [i]
        dataset._sequence_length = self._sequence_length
        dataset._sequence_mode = self._sequence_mode
        dataset._sequence_dim = self._sequence_dim
        dataset._pre_transform = self._pre_transform
        dataset.dtype = self.dtype
        return dataset

    """
    def retrieve_from_class(self, task, labels):
        valid_classes = [self.classes[task][i] for i in labels]
        ids = np.where(np.in1d(self.metadata[task], valid_classes))[0]
        return self.retrieve(ids)
    """

    def check_audio_folder(self) -> bool:
        """Performs a checking pass over dataset files."""
        check = True
        for f in tqdm(self.files, total=len(self.files), desc="Checking audio files..."):
            try:
                x, y = parse_audio_file(self.root_directory+"/"+f, sr=self.sr, len=self.target_length)
            except Exception as e:
                print("Problem with file %s"%f)
                print("Exception : %s" % e)
                check = False
                pass
        return check

    def parse_files(self) -> None:
        """
        parses root directory.
        """
        files = []
        for r, d, f in os.walk(self.root_directory+"/data"):
            for f_tmp in f:
                if os.path.splitext(f_tmp)[1] in self.types:
                    f_tmp = re.sub(os.path.abspath(self.root_directory), '', os.path.abspath(r+'/'+f_tmp))[1:]
                    files.append(f_tmp)
        self.files = files
        self.hash = {self.files[i]:i for i in range(len(self.files))}

    def import_data(self, scale: bool = True, write_transforms: bool = False,
            save_transform_as: str = None, min_len: int = None, force: bool = False) -> None:
        """
        Import data listed in dataset files.
        Args:
            scale (bool): scale transforms after import (default: True)
            write_transforms (bool): writes transform into dataset data.
            save_transform_as (str): writes transform to the transforms/ folder.
            min_len (int): asserts a minimum size for import size
            force (bool): overwrites transform if a transform of the same name is found.
        """

        if len(self.files) == 0:
            raise ValueError("Trying to import data from an empty dataset at %s."%self.root_directory)
        data = []
        metadata = {}
        files = []
        hash = {}
        running_id = 0
        for i, f in tqdm(enumerate(self.files), total=len(self.files), desc="Importing audio files..."):
            current_data, current_metadata = parse_audio_file(os.path.abspath(self.root_directory+"/"+f),
                    sr=self.sr, len=self.target_length, min_len = min_len)
            if len(metadata.keys()) == 0:
                metadata = {k: [] for k in current_metadata.keys()}
            data.append(current_data)
            hash[f] = running_id
            for k, v in current_metadata.items():
                metadata[k].append(v)
            running_id += 1
            files.append(self.files[i])
            hash[self.files[i]] = i

        self.data = data
        self.hash = hash
        self.files = files

        self.metadata = {**self.import_metadata(), **metadata}
        if scale:
            # scale current transforms to imported data.
            self.scale_transform(self.scale_amount)
        if write_transforms:
            assert save_transform_as is not None, "if write_transforms is True, save_transform_as must be given a string"
            self.write_transforms(save_as=save_transform_as, force=force)

    def scale_transform(self, scale: Union[int, bool], mode: str = "pad") -> None:
        """
        Scales current transform on a given amount of data.
        Args:
            scale (int, bool): amount of data used for scaling. If True, takes all the data.
        """
        if scale and self._transforms is not None:
            if scale is True:
                self._transforms.scale(self.data[:])
            elif isinstance(scale, int):
                idx = torch.randperm(len(self.data))[:scale]
                if mode == "pad":
                    scale_data = pad_data([checktensor(self.data[i.item()]) for i in idx])
                elif mode == "crop":
                    scale_data = crop_data([checktensor(self.data[i.item()]) for i in idx])
                self._transforms.scale_data(scale_data)

    def import_transform(self, transform: str, n_files: int = None) -> AudioTransform:
        """
        Imports the target data.
        Args:
            transform (str): name of transform to import.

        Returns:
            original_transform (AudioTransform): transform used before export.

        """
        assert transform in self.available_transforms
        target_directory = f"{self.root_directory}/transforms/{transform}"
        if len(self.files) > 0:
            files = [os.path.splitext(re.sub('data/','', f))[0] + lardon.lardon_ext for f in self.files]
        else:
            files = None
        if n_files is not None: 
            files = [files[i] for i in np.random.permutation(len(files))[:int(n_files)]]
        self.data, imported_metadata = lardon.parse_folder(target_directory, drop_metadata=True, files=files)
        with open(target_directory+'/transforms.ct', 'rb') as f:
            original_transform = dill.load(f)
        with open(target_directory + '/dataset.ct', 'rb') as f:
            save_dict = dill.load(f)
            self.load_dict(save_dict)
        self._pre_transform = original_transform
        self.metadata = {**self.metadata, **imported_metadata, **self.import_metadata()}
        return original_transform

    def import_metadata(self):
        metadata_directory = f"{self.root_directory}/metadata"
        if not os.path.isdir(metadata_directory):
            return {}

        task_test = lambda x: os.path.isdir(f"{metadata_directory}/{x}") \
                and os.path.isfile(f"{metadata_directory}/{x}/metadata.txt")
        tasks = list(filter(task_test, os.listdir(metadata_directory)))

        metadata = {}
        for t in tasks:
            callback = get_callback_from_config(self.metadata_callbacks.get(t, {}))
            if callback is None:
                print('[Warning] could not find callback for task %s'%t)
                continue
            if os.path.isfile(f"{metadata_directory}/{t}/classes.txt"):
                self.classes[t] = {}
                with open(f"{metadata_directory}/{t}/classes.txt", 'r') as f:
                    for l in f.readlines():
                        class_id, name = re.sub('\n', '',l).split('\t')
                        self.classes[t][int(class_id)] = name
            current_hash = {}
            current_directory = f"{metadata_directory}/{t}"
            metadata[t] = [None] * len(self.files)
            with open(f"{current_directory}/metadata.txt") as metafile:
                for line in metafile.readlines():
                    file, raw_metadata = line.replace('\n', '').split('\t')
                    current_hash[file] = raw_metadata
            for file, idx in self.hash.items():
                if file in current_hash.keys():
                    current_metadata = callback(current_hash[file], current_path=current_directory)
                    metadata[t][idx] = current_metadata
                else:
                    print('warning : file %s not found in metadata'%(file, ))
        return metadata

    def write_transforms(self, save_as=None, force=False) -> None:
        """
        Write transforms in place, parsing the files to the target transform using lardon.
        Note : dataset should not be flattened if exported, providing degenerated lardon pickling.

        Args:
            save_as (str): named of exported transform. If None, data is not exported. (default : None)
            force (int): overwrites transform if found a transform with the same name. (default: False)
        """

        transformed_meta = []
        target_directory = f"{self.root_directory}/transforms/{save_as}"
        if save_as:
            if self._flattened:
                raise Exception('trying to export a flattened dataset.')
            with lardon.LardonParser(self.root_directory+'/data', target_directory, force=force) as parser:
                for i, d in enumerate(tqdm(self.data, desc="exporting transforms...", total=len(self.data))):
                    time = torch.tensor([0.]) if not "time" in self.metadata['time'] else self.metadata['time'][i]
                    new_data, new_time = self._transforms.forward_with_time(d, time=time)
                    new_data = checknumpy(new_data)
                    transformed_meta.append({'time':new_time.numpy(), 'sr':self.metadata['sr'][i]})
                    if save_as is not None:
                        parser.register(new_data, transformed_meta[-1], filename=(f"{self.root_directory}/{self.files[i]}"))
                    # transformed_data.append(new_data.numpy()); transformed_meta.append({'time': new_time.numpy()})
                    # transformed_data.append(selector(new_data)); transformed_time.append(selector(new_time))
            transformed_data = lardon.parse_folder(target_directory)
            transformed_meta = {k: [t[k] for t in transformed_meta] for k in transformed_meta[0].keys()}
            self.data = transformed_data
            self.metadata = {**self.metadata, **transformed_meta}
            with open(f"{target_directory}/transforms.ct", 'wb') as f:
                dill.dump(self._transforms, f)
            self._transforms = AudioTransform()
            save_dict = self.get_attributes(with_data=False)
            with open(f"{target_directory}/dataset.ct", "wb") as f:
                dill.dump(save_dict, f)
        else:
            transformed_data = []
            for i, d in enumerate(tqdm(self.data, desc="replacing transforms...", total=len(self.data))):
                time = torch.tensor([0.]) if not "time" in self.metadata['time'] else self.metadata['time'][i]
                new_data, new_time = self._transforms(d, time=time, sr=self.metadata['sr'][i])
                transformed_data.append(new_data)
                transformed_meta.append({'time': new_time, 'sr': self.metadata['sr'][i]})
            transformed_meta = {k: [t[k] for t in transformed_meta] for k in transformed_meta[0].keys()}
            self._pre_transforms = self._transforms
            self._transforms = AudioTransform()
            self.data = transformed_data
            self.metadata = {**self.metadata, **transformed_meta}

    def flatten_data(self, axis=0) -> None:
        """
        Flattens the content of dataset's nested data among given axis.
        Args:
            axis (int): flattened axis

        """
        data = []
        metadata = {k: [] for k in self.metadata.keys()}
        metadata['time'] = []
        files = []
        hash = {}
        running_id = 0
        for i, d in tqdm(enumerate(self.data), desc="Flattening data...", total=len(self.data)):
            if isinstance(self.data, lardon.OfflineDataList):
                current_data = self.data.entries[i].scatter(axis)
            else:
                current_data = self.data[i].split(1, dim=axis)
            data.extend(current_data)
            # manage metadata
            for k in self.metadata.keys():
                if self.metadata[k][i] is None:
                    continue
                elif isinstance(self.metadata[k][i], ContinuousList):
                    time = self.metadata['time'][i]
                    metadata[k].extend(self.metadata[k][i][time])
                elif isinstance(self.metadata[k][i], (np.ndarray)) or torch.is_tensor(self.metadata[k][i]):
                    if self.metadata[k][i].shape[0] == len(current_data):
                        metadata[k].extend(self.metadata[k][i])
                    else:
                        if len(self.metadata[k][i].shape) == 1:
                            assert self.metadata[k][i].shape[0] == 1, "invalid metadata size for task %s : found %s, but data shape is %s" % (k, self.metadata[k][i].shape, len(current_data))
                            metadata[k].append(self.metadata[k][i].repeat(len(current_data)))
                        else:
                            metadata[k].append(self.metadata[k][i].repeat(len(current_data)))
                else:
                    metadata[k].extend([self.metadata[k][i]]*len(current_data))
            hash[self.files[i]] = list(range(running_id, running_id + len(current_data)))
            files.extend([self.files[i]] * len(current_data))
            running_id += len(current_data)

        if isinstance(data[0], lardon.OfflineEntry):
            self.data = lardon.OfflineDataList(data)
        else:
            self.data = data
        self.metadata = metadata
        self.hash = hash
        self.files = files
        self._sequence_dim = None
        self._sequence_length = None
        self._flattened = axis


    def get_attributes(self, with_data=True) -> dict:
        """
        Get a dict version of the dataset (convenient for pickling)
        Returns:
            save_dict (dict) : dictionary
        """
        return {
                'data': self.data if with_data else None,
                'metadata': self.metadata,
                'files':self.files,
                'hash':self.hash,
                'sr': self.sr,
                'bitrate': self.bitrate,
                'dtype': self.dtype,
                'transforms':self._transforms,
                'root_directory':self.root_directory,
                'partitions':self.partitions,
                'partition_files': self.partition_files,
                'target_length': self.target_length,
                'pre_transform': self._pre_transform,
                'sequence_mode': self._sequence_mode,
                'sequence_length': self._sequence_length,
                'sequence_dim':self._sequence_dim,
                'flattened': self._flattened}

        def save(self, name: str, write_transforms: bool = False, **kwargs) -> None:
            """Manage folders and save data to disk

        Args:
            name (str): dataset instance name
            write_transforms (bool): If True saves the current instance as a dict. Defaults to True.
        """
        if not os.path.isdir(self.root_directory+'/pickles'):
            os.makedirs(self.root_directory+'/pickles')
        if write_transforms:
            self.write_transforms(name, flatten=False)
        save_dict = {**self.get_attributes(), **kwargs}
        filename = f"{self.root_directory}/pickles/{name}.ctp"
        with open(filename, 'wb') as savefile:
            dill.dump(save_dict, savefile)

    def load_dict(self, save_dict: dict) -> None:
        """
        Loads a dataset from its save dict, exported by the save method.
        Args:
            save_dict (dict): saved dict
        """
        files = []; hash = {}
        for f in save_dict['files']:
            new_file = re.sub(save_dict['root_directory'], self.root_directory, f)
            files.append(new_file)
            hash[new_file] = save_dict['hash'][f]
        self.files = files
        self.hash = hash
        if save_dict.get('data'):
            self.data = save_dict.get('data')
        if save_dict.get('metadata'):
            self.metadata = save_dict.get('metadata')
        self.sr = save_dict.get('sr')
        self.bitrate = save_dict.get('bitrate')
        self.dtype = save_dict.get('dtype')
        self.target_length = save_dict.get('target_length')
        self.partitions = save_dict.get('partitions', {})
        self.partition_files = save_dict.get('partition_files')
        self._active_tasks = save_dict.get('active_tasks', [])
        self._pre_transform =save_dict.get('pre_transform')
        # self._sequence_mode = save_dict.get('sequence_mode')
        # self._sequence_length = save_dict.get('sequence_length')
        # self._sequence_dim = save_dict.get('sequence_dim')
        self._flattened = save_dict.get('flattened', False)

    def get_data_from_files(self, f, batch=True, augment=False):
        f = re.sub(self.root_directory, "", f)
        if not f in self.files:
            print('[Warning] asking for file %s, not present in the dataset. Returning none'%f)
        idx = self.hash[f]
        x = []; y = {k: [] for k in self.metadata.keys()}
        for i in checklist(idx):
            x_tmp, y_tmp = self.__getitem__(i, augment=False)
            x.append(x_tmp)
            for k in y.keys():
                y[k].append(y_tmp[k])
        x = torch.stack(x, 0)
        y = {k: torch.stack(v, 0) for k, v in y.items()}
        if batch:
            x = x.unsqueeze(0)
            y = {k: v.unsqueeze(0) for k, v in y.items()}
        return x, y

    def transform_file(self, file: str) -> Tuple[torch.Tensor, dict]:
        """
        Transforms a given file.
        Args:
            file (str): file to load and transform

        Returns:
            data(torch.Tensor): transformed data
            metadata (dict): imported metadata

        """
        data, meta = parse_audio_file(file, self.sr, len=self.target_length, bitrate=self.bitrate)
        if self._pre_transform is not None:
            data, meta['time'] = self._pre_transform.forward_with_time(data, time=meta['time'])
        if self._flattened is not None:
            data = torch.stack([d.squeeze(self._flattened) for d in data.split(1, self._flattened)])
        data, meta['time'] = self._transforms.forward_with_time(data, time=meta['time'])
        if self.dtype is not None:
            data = data.to(self.dtype)
        return data, meta

    def invert_transform(self, data: torch.Tensor):
        """
        Takes a transformed data and revert it to its original waveform.
        Args:
            data (torch.Tensor): data to revert

        Returns:

        """
        if self._transforms.invertible:
            inv_data = self._transforms.invert(data)
        else:
            raise NotInvertibleError
        if self._flattened is not None:
            inv_data = torch.stack(list(inv_data), self._flattened)
        if self._pre_transform is not None:
            if self._pre_transform.invertible:
                inv_data = self._pre_transform.invert(inv_data)
            else:
                raise NotInvertibleError
        return inv_data


