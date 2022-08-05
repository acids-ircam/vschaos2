from numpy import isin
import torch, torch.distributions as dist, sys, pdb
sys.path.append("../")
from vschaos.utils.misc import _recursive_to
import pytorch_lightning as pl
from pytorch_lightning.callbacks import Callback
from pytorch_lightning.trainer.states import RunningStage, TrainerFn, TrainerState, TrainerStatus

def update_dict(memory, new_dict):
    for k, v in new_dict.items():
        if k in memory.keys():
            memory[k].append(v)
        else:
            memory[k] = [v]
    return memory

def reduce_dict(dic):
    reduced_dict = {}
    for k, v in dic.items():
        if isinstance(v, dict):
            reduced_dict = {**reduced_dict, **reduce_dict(v)}
        else:
            reduced_dict = {**reduced_dict, **{f"{k}/{k_tmp}": v_tmp for k_tmp, v_tmp in v.items()}}
    return reduced_dict

def accumulate_traces(traces):
    trace_dict = {}
    if "histograms" in traces[0].keys():
        trace_dict['histograms'] = {}
        hist_keys = traces[0]['histograms'].keys()
        for k in hist_keys:
            if isinstance(traces[0]['histograms'][k], dict):
                current_dict = {k_tmp: torch.cat([v['histograms'][k][k_tmp] for v in traces]) for k_tmp in traces[0]['histograms'][k].keys()}
                for k_tmp, v_tmp in current_dict.items():
                    trace_dict['histograms'][f"{k}/{k_tmp}"] = v_tmp
            else:
                trace_dict['histograms'][k] = torch.cat([v['histograms'][k] for v in traces])
    if "embeddings" in traces[0].keys():
        trace_dict['embeddings'] = {}
        emb_keys = traces[0]['embeddings'].keys()
        for k in emb_keys:
            if torch.is_tensor(traces[0]['embeddings'][k]):
                trace_dict['embeddings'][k] = torch.cat([v['embeddings'][k] for v in traces])
            else:
                trace_dict['embeddings'][k] = {}
                trace_dict['embeddings'][k]['data'] = torch.cat([v['embeddings'][k]['data'] for v in traces])
                if traces[0]['embeddings'][k].get('label_img') is not None:
                    trace_dict['embeddings'][k]['label_img'] = torch.cat([v['embeddings'][k]['label_img'] for v in traces])
                if traces[0]['embeddings'][k].get('metadata') is not None:
                    trace_dict['embeddings'][k]['metadata'] = {}
                    for j in traces[0]['embeddings'][k]['metadata'].keys():
                        trace_dict['embeddings'][k]['metadata'][j] = torch.cat([v['embeddings'][k]['metadata'][j] for v in traces])
                
    return trace_dict



class DissectionMonitor(Callback):

    def __init__(self, n_batches=5, batch_size=1024, monitor_epochs=1, embedding_epochs=10):
        """
        Callback for monitoring and dissecting the model's guts.
        Args:
            n_batches (int): number of batches (default: 5)
            batch_size (int): batch size (default: 1024)
            monitor_epochs (int): monitoring period in epochs (default: 1)
            embedding_epochs (int): embedding plot period in epochs (default: 10)
        """
        self.n_batches = n_batches
        self.batch_size = batch_size
        self.monitor_epochs = monitor_epochs
        self.embedding_epochs = embedding_epochs

    def on_validation_epoch_end(self, trainer: pl.Trainer, pl_module: pl.LightningModule):
        with torch.no_grad():
            if trainer.state.stage == RunningStage.SANITY_CHECKING:
                return
            if trainer.current_epoch % self.monitor_epochs != 0:
                return
            # plot model parameters distribution
            for k, v  in trainer.model.named_parameters():
                if v.isnan().any():
                    print("[Warning] parameter %s has a nan value.")
                else: 
                    trainer.logger.experiment.add_histogram("params/"+k, v, global_step=trainer.current_epoch)
            n_batch = 0
            traces = []
            if not hasattr(trainer.model, "trace"):
                return 
            loader = trainer.datamodule.train_dataloader(batch_size=self.batch_size, drop_last=False)
            for i, data in enumerate(loader):
                # weird bug occuring with padded_convs when batch size is irregular.
                if i == len(loader) - 1:
                    break
                trace_out = pl_module.trace(_recursive_to(data, pl_module.device))
                n_batch += 1
                traces.append(trace_out)
                if n_batch > self.n_batches:
                    break

            if len(traces) != 0:
                trace = accumulate_traces(traces)
                for k, v in trace.get('histograms', {}).items():
                    trainer.logger.experiment.add_histogram(k, v, global_step = trainer.current_epoch)
                if trainer.current_epoch % self.embedding_epochs == 0:
                    for k, v in trace.get('embeddings', {}).items():
                        label_img = None; metadata = None; header = None
                        if isinstance(v, dict):
                            label_img = v.get('label_img')
                            metadata = v.get('metadata')
                            v = v['data']
                        if len(v.shape) != 2:
                            v = v.reshape(-1, v.size(-1))
                        if metadata is not None:
                            metadatas = []; header = []
                            for k, m in metadata.items():
                                header.append(k)
                                metadatas.append(m.squeeze())
                            metadata = torch.stack(metadatas, 1)
                        trainer.logger.experiment.add_embedding(v, tag=k, label_img=label_img, metadata=metadata.tolist(), metadata_header=header, global_step=trainer.current_epoch)

