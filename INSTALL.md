## Installation

### Prerequisites (maybe work with others hardware and Operating System)
- OS: Windows 11 or Windoes 10 Home 21H2 or Ubuntu 20.04 LTS
- Docker 2.3.0.2 or a later release.
- NVIDIA CUDA-enabled driver for WSL (https://docs.microsoft.com/es-es/windows/ai/directml/gpu-cuda-in-wsl)
- GPU: GeForce RTX 3090
- RAM: 64 Gb
- Free disk space
- Visual Studio Code

### Steps of installation
```
# Open terminal (For example: WindowsPowerShell) and execute:

# create docker image:
docker build -t uam_vqa:feature_example_of_one_case .

# create docker container (change "C:\proyectos\intercambio" for path where you do you want to have a replic of "/proyectos/intercambio"):
docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -it --rm -v C:\proyectos\intercambio:/proyectos/intercambio uam_vqa:feature_example_of_one_case
```
