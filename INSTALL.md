## Installation

### Prerequisites (maybe work with others hardware and Operating System)
- OS: UBUNTU 20.04 LTS
- Python: 3.8.10
- GPU: GeForce RTX 3090
- RAM: 64 Gb
- Free disk space

### Steps of installation
```
# Create new virtual enviroment:
python3 -m venv ./venv

# Activate virtual enviroment:
source ./venv/bin/activate

# Install Pre-Built Detectron2 (Linux only):
pip install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html

# Install wheel:
pip install wheel

# Update setuptools:
pip install -U pip setuptools

# Create repositories folder:
mkdir repositories
# Open repositories folder:
cd repositories
# Add submodule of MILVLG/bottom-up-attention.pytorch
git submodule add https://github.com/carlosgalve92/bottom-up-attention.pytorch.git
# Open new submodule folder:
cd bottom-up-attention.pytorch/
# Pull commit version of detetron 2 (submodule in MILVLG/bottom-up-attention.pytorch):
git submodule update --init --recursive
# Install detectron2 from a local clone:
pip install -e ./detectron2
# install the rest modules
python setup.py build develop

# Install pycocotools:
pip install pycocotools

# Install opencv-python(cv2):
pip install opencv-python

# Install jupyter:
pip install jupyter

# Install apex
cd ..
git submodule add https://github.com/carlosgalve92/apex.git
cd apex
python setup.py install

# Install ray
pip install ray

# Install boto3 (Accessing files from S3 directly).
pip install boto3

# Install request (Used for downloading models over HTTP)
pip install requests

# Add submodule
cd ..
git submodule add https://github.com/carlosgalve92/lxmert.git
# end
```
