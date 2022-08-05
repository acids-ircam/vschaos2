import os, sys

from fsspec import Callback
sys.path.append('../')
from vschaos.utils.misc import ContinuousList

def read_single_metadata(cast=str):
    def closure(meta, **kwargs):
        if cast is None:
            return meta
        else:
            return cast(meta)
    return closure

def parse_temporal_with_onsets(type):
    def closure(filename, cast=None, current_path=None):
        file_path = f"{current_path}/tracks/{filename}"
        if not os.path.isfile(file_path):
            raise FileNotFoundError(file_path)
        file_path = os.path.abspath(file_path)
        metas = ContinuousList()
        with open(file_path) as f:
            for line in f.readlines():
                separator = "\t" if "\t" in line else ","
                splits = line.replace('\n', '').split(separator)
                if len(splits) > 3:
                    splits = (splits[0], splits[1], separator.join(splits[2:]))
                if cast is not None:
                    splits[2] = cast[splits]
                onset, offset, chord = splits
                metas[float(onset)] = chord
        return metas
    return closure


metadata_hash = {'chord': parse_temporal_with_onsets(str),
                 'tempo': read_single_metadata(float),
                 'importRawInt': read_single_metadata(int),
                 'importRawFloat': read_single_metadata(float)}
