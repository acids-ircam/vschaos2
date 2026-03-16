import hydra
from omegaconf import DictConfig
from vschaos.train import train

@hydra.main(config_path="configs", config_name="config", version_base="1.2")
def main(config: DictConfig, ckpt_path=None):
    train(config)

if __name__ == "__main__":
    main()
