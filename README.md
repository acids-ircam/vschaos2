# vschaos2

`vschaos2`, [based on the original `vschaos` package](https://github.com/domkirke/vschaos) [1][2], is a vintage-flavoured neural audio synthesis package. It is based on unsupervised / (semi-)supervised training of spectral information using variational auto-encoders [3], allowing direct manipulation in Max/MSP or PureData environments using [nn_tilde](https://github.com/acids-ircam/nn_tilde). `vschaos2` may be trained on small batches of data, is very light, usable using small architectures, and can also be used for auxiliary predictive tasks.

See an example of vschaos in live action [here](https://www.youtube.com/watch?v=zGnvID6EMbU&list=PLScv8n5132x_6OR7cPQ2yWW4GDtOboRWW&index=4).

# Quick Start
1. Download the current repository.
2. If you don't have PureData or Max, [download PureData for free](https://puredata.info/) or [Max for evaluation](https://cycling74.com/downloads).
3. Install nn~ following instructions [here](https://github.com/acids-ircam/).
4. Download the `ordinario` pre-trained model on [the ACIDS github page](acids-ircam.github.io) into the `patches` subfolder if using Max, or in the `externals` sub-folder or Pd Library.
5. Open `pd_example.pd` or `max_example.maxpat`, depending the choice you made at step 1.
6. Play!

# Full install 
## Installing vschaos2
Use your favorite environment manager to create a specific python environment for `vschaos2` (we advise to use [the miniconda package manager](https://docs.conda.io/en/latest/miniconda.html)). Using miniconda : 
```sh
cd your_target_folder
git clone http://www.github.com/acids_ircam/vschaos2
cd vschaos2
conda create -n vschaos python=3.8 setuptools==59.5.0
conda activate vschaos
pip install -r requirements.txt
```
###### You may need to manually install pytorch before `pip install` if you got specific CUDA needs : find more information [here](https://pytorch.org/).


## Data management
The only requirements for a dataset is to put all the target audio files in a subfolder `data/`, and the corresponding metadata files in a subfolder `metadata/`. Hence, the directory tree must be like 
```
my_dataset/
    data/
        [...files]
    metadata/
        task_1/
            metadata.txt
            classes.txt [optional]
        task_2/
            ...
```
### Metadata
Metadata can be specified in two different ways. If every file belong to a single class, metadata may only containt the `metadata.txt` files wit the following information : 
```
data/..../file1.wav metadata
data/..../file2.wav metadata
...
```
where key and field are separated by a `\t` character. If metadata changes during the audio file, an additional folder `tracks` folder must be added such that the `metadata.txt` contains 
```
data/..../file1.wav tracks/metadata_file1.txt
data/..../file2.wav tracks/metadata_file2.txt
...
```

and the folder `tracks` contains the metadata for each audio file in a separated text file, containing
```
0.0,1.0 metadata1
1.0,1.025 metadata2
```
where onsets and offsets are indicated in seconds (separated by a comma), and are separated from metadata by a `\t` character. Metadata can be float,int, or `none`, hence allowing semi-supervised training.


## Training a model
### Unsupervised model
Model configurations are based on the `hydra` configuration manager, using `.yaml` to specify the VAE's architecture. Commented configurations are given in the `configs/` folder, such that you only need to specify the data path and the tranining root / name : 
```bash
python3 train_model.py --config-name dgt_mid name=my_training rundir=my_path +data.dataset.root=my_data
```
where `--config-name` is followed by the name of a configuration file in the `configs/` subfolder, `my_training` is a customized training name, `my_path` the location of the training, and `my_data` is the path of a formatted dataset (see section [data management](#data-management)).

### Supervised model
Conditioning variational auto-encoders may be achieved in a semi-supervised fashion, allowing to constrain the generation to high-level external information [4]. 

**Specifying metadata callbacks.** By default, metadata is imported as `int` labels. If you want a precise control over metadata parsing, additional arguments may be given to the dataset in the `.yaml` file : 
```yaml
data:
  dataset:
    metadata_callbacks:
      task_1:
        name: read_single_metadata
        type: int
      task_2:
        name: read_single_metadata
        type: float
      ...
```
where you would use `read_single_metadata` if metadata if each audio file belongs to a single class, and `read_multi_metadata` if metadata is scattered as multiple text files in a `tracks/` sub-folder. 

**Specifying conditioning tasks.** To condition a model, you must add an additional `conditioning` entry to the `model` configuration :
```yaml
model:
  conditioning:
    task_1: 
      dim: task_dim_1
      target: ['encoder', 'decoder']
      embedding: OneHot
    task_2:
      dim: task_dim_2
      target: ['decoder']
      embedding: OneHot
   ... 
```
where `dim`, `target`, and `embedding` keywords define respectively the dimensionality, target module, and embedding type for each task. Conditioning the decoder will encourage the model to disentangle the class information from the latent space, allowing to control the generation by giving the corresponding label. Conditioning the encoder will rather provide a different latent space by label, hence enforcing class separation (at the cost of being always provided the label for the encoding process).

**Predicting labels.** Additional predictors can be provided to the model, that will be available as an additional output in the `nn~` module and that can be used for conditioning the decoder even if label information is unavailable. To add predictors to the model, you must add an additional `prediction` entry to the `model` configuration : 
```yaml
model:
  prediction:
    task_1:
      dim: task_dim_1
      type: MLPEncoder 
      args: 
        nlayers: 2
        hidden_dims: 200
        target_dist: Categorical
    ...
```
Prediction modules are trained besides the VAE (with a stop gradient before the classifier), such that the encoder is not influenced by the classification results. If label information is available, the classifier is trained to predict the corresponiding label; if it is not, it is trained on random values. Be careful to not predict a label that is conditioning the encoder!

**Example with pitch & octave.** A script is provided to generate pitch and octave metadata using the `torchcrepe` package. After having moved the audio files into the `/data` subfolder, generate metadata files by launching
```sh
python3 extract_pitch.py my_data
```
such that `pitch` and `octave` metadatas will be generated in the `/metadata` sub-folder. Then, you can use the `dgt_pitch_cond` config file to train a parametrized VAE on `pitch` and `octave` : 
```sh
python3 train.py --config-name dgt_pitch_prediction name=my_training rundir=my_path data.dataset.root=my_data
```
such that the model's decoder will be conditioned by both pitch and octave, that can be provided by the predictor if the corresponding label is missing. 

### Tricks
- You can add the `+check=1` option to `train.py` to add a breakpoint before lauching the training loop, allowing to check the architecture of your model and your dataset.
- You can also add the `+data.dataset.n_files=X` to only load `X` files from your dataset, allowing you to train on small data subsets to verify that your training setup works.

## Generating with a trained model

### Command-line generation
The script `generate.py` allows to generate from a model using the command line. There two generation modes so far : `reconstruct`, to reconstruct a given bunch of files thourgh the model, and `trajectories`, leveraging the [`trajectories` library](https://github.com/domkirke/trajectories) to generate latent space exploration.

**Reconstruction.** To reconstruct a file through a model, you can execute 
```sh
python3 generate.py reconstruct path_to_rundir --files path_to_audio.wav path_to_audio_folder/ --sr 44100 --out path_to_out/
```
to export the generations in the `path_to_out/reconstructions` folder. 

**Trajectories.** To directly generate from the latent space from random trajectories, you can execute
```sh
python3 generate.py trajectories path_to_rundir --trajectories sin random line --sr 44100 -b 3 -s 512 --out path_to_out/
```
to generate 3 batches of random sin, random and line 512-stepped trajectories, that will be saved in the `path_to_out/trajectories`.

### Exporting for nn~
To export a model, just use the `script.py` with the training folder : 
```sh
python3 script.py path_to_model/ -o output_dir/ -v version_number -n name
```
where `path_to_model/` is the training `rundir`, `version_number` is the version number of the training (if not indicated, take the last training) and `name` the model name (default : `last`). The `.ts` file will be exported at `path_to_model/`, and can be imported by `nn~`. 

# References

[1] Chemla--Romeu-Santos, A. (2020). [Manifold representations of musical signals and generative spaces](https://hal.archives-ouvertes.fr/tel-03543235). PhD thesis

[2] Chemla--Romeu-Santos, A., Esling, P., & Ntalampiras, S. (2020, October). [Représentations variationnelles inversibles: une nouvelle approche pour la synthèse sonore](https://hal.archives-ouvertes.fr/hal-03353913). In Journées d'Informatique Musicale 2020 (JIM 2020).

[3] Kingma, D. P., & Welling, M. (2013). [Auto-encoding variational bayes](https://arxiv.org/abs/1312.6114). arXiv preprint arXiv:1312.6114

[4] Kingma, D. P., Mohamed, S., Jimenez Rezende, D., & Welling, M. (2014). [Semi-supervised learning with deep generative models](https://proceedings.neurips.cc/paper/2014/file/d523773c6b194f37b938d340d5d02232-Paper.pdf). Advances in neural information processing systems, 27
