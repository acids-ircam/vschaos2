import os, sys
from os.path import join, isdir, isfile
from torch import nan

from fsspec import Callback
sys.path.append('../')
from vschaos.utils.misc import ContinuousList


def read_metadata(cast=str):
    def closure(meta, current_path=None):
        file_path = join(current_path, "tracks", meta)
        if os.path.isfile(file_path):
            return read_multi_metadata(cast)(file_path, current_path=current_path)
        else:
            return read_single_metadata(cast)(meta)
    return closure 


def read_single_metadata(cast=str):
    def closure(meta, **kwargs):
        if cast is None:
            return meta
        else:
            return cast(meta)
    return closure


def read_multi_metadata(type_class):
    def closure(filename, current_path=None):
        assert current_path is not None
        assert isfile(join(current_path, 'tracks', filename))
        file_path = join(current_path, "tracks", filename)
        if not os.path.isfile(file_path):
            raise FileNotFoundError(file_path)
        file_path = os.path.abspath(file_path)
        metas = ContinuousList()
        with open(file_path) as f:
            for line in f.readlines():
                time, meta = line.split('\t')
                onset, offset = time.split(',')
                if meta[-1] == '\n':
                    meta = meta[:-1]
                # separator = "\t" if "\t" in line else ","
                # splits = line.replace('\n', '').split(separator)
                # if len(splits) > 3:
                #     splits = (splits[0], splits[1], separator.join(splits[2:]))
                # if cast is not None:
                #     splits[2] = cast[splits]
                if meta in ['none', 'None', None, 'nan']:
                    meta = nan 
                else:
                    meta = type_class(meta)
                metas[float(onset)] = meta
        return metas
    return closure


metadata_hash = {'chord': read_multi_metadata(str),
                 'tempo': read_single_metadata(float),
                 'importRawInt': read_single_metadata(int),
                 'importRawFloat': read_single_metadata(float)}
