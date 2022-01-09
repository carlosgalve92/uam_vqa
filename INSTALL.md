## Installation

### Prerequisites (maybe work with others hardware and Operating System)
- Docker 2.3.0.2 or a later release.
- NVIDIA CUDA-enabled driver (and Nvidia DOcker) on Ubuntu 20.04 LTS 
- NVIDIA CUDA-enabled driver for WSL (https://docs.microsoft.com/es-es/windows/ai/directml/gpu-cuda-in-wsl) on OS of Windows 11 or Windoes 10 Home 21H2
- GPU: GeForce RTX 3090
- RAM: 64 Gb
- Free disk space

### Steps of installation
```
# Open terminal (For example: WindowsPowerShell) and execute:

# create docker image:
docker build -t uam_vqa:feature_example_of_one_case .

# create docker container (change "C:\proyectos\intercambio" for path where you want to have a replic of "/proyectos/intercambio"):
docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -it --name feature_example_of_one_case -v C:\proyectos\intercambio:/proyectos/intercambio uam_vqa:feature_example_of_one_case
```
