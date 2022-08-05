import os, re
from weakref import proxy
from pytorch_lightning.callbacks import *
from vschaos.utils import checkdir, get_root_dir
from pytorch_lightning.trainer.states import RunningStage


# def checkup_save_dir(dirpath):
#     if not os.path.isdir(dirpath):
#         os.makedirs(f"{dirpath}")
#     folder_list = list(filter(lambda x: os.path.isdir(x), os.listdir(dirpath)))
#     folder_list = list(filter(lambda x: re.match("version_(\d)+", x) is not None, folder_list))
#     if len(folder_list) == 0:
#         dirpath = f"{dirpath}/version_1"
#         if not os.path.isdir(dirpath):
#             os.makedirs(dirpath)
#         return dirpath, 1
#     else:
#         versions = list(filter(lambda x: re.match("version_(\d)+", x).groups()[0], os.listdir(folder_list)))
#         current_version = max(versions) + 1
#         dirpath = f"{dirpath}/version_{current_version}"
#         if not os.path.isdir(dirpath):
#             os.makedirs(dirpath)
#         return dirpath, current_version


class ModelCheckpoint(ModelCheckpoint):
    FILE_EXTENSION = ".vs"
    def __init__(self, dirpath=None, filename=None, epoch_schedule=None, epoch_period=None, **kwargs):
        self.STARTING_VERSION = int(re.match(r".*/version_(\d)+.*", dirpath).groups()[0])
        super(ModelCheckpoint, self).__init__(dirpath=dirpath, filename=filename+"_{epoch}", **kwargs)
        self.epoch_period = epoch_period
        self.epoch_schedule = epoch_schedule
        self.epochs_dir = os.path.join(dirpath, "epochs")
        if (self.epoch_schedule) or (self.epoch_period):
            if not os.path.isdir(self.epochs_dir):
                os.makedirs(self.epochs_dir)

    def _notify(self, trainer):
        if trainer.is_global_zero:
            for logger in trainer.loggers:
                logger.after_save_checkpoint(proxy(self))

    def format_checkpoint_name_epochs(self, metrics, filename = None, ver = None) -> str:
        filename = filename or self.filename
        filename = self._format_checkpoint_name(filename, metrics, auto_insert_metric_name=self.auto_insert_metric_name)

        if ver is not None:
            filename = self.CHECKPOINT_JOIN_CHAR.join((filename, f"v{ver}"))

        ckpt_name = f"{filename}{self.FILE_EXTENSION}"
        return os.path.join(self.dirpath, "epochs", ckpt_name) if self.dirpath else ckpt_name

    def on_train_epoch_end(self, trainer, pl_module):
        super(ModelCheckpoint, self).on_train_epoch_end(trainer, pl_module)
        if self.epoch_period is not None:
            if trainer.current_epoch % self.epoch_period == 0:
                filepath = self.format_checkpoint_name_epochs(self._monitor_candidates(trainer))
                trainer.save_checkpoint(filepath, self.save_weights_only)
                # self._notify(trainer)
        if self.epoch_schedule is not None:
            if trainer.current_epoch in self.epoch_schedule:
                filepath = self.format_checkpoint_name_epochs(self._monitor_candidates(trainer))
                trainer.save_checkpoint(filepath, self.save_weights_only)
                # self._notify(trainer)