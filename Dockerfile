FROM nvcr.io/nvidia/pytorch:21.07-py3

WORKDIR /proyectos/uam_vqa

COPY . .

RUN  ls -la && git submodule update --init --recursive

RUN pip install wheel
RUN pip install -U pip setuptools
RUN pip install -e /proyectos/uam_vqa/repositories/bottom-up-attention.pytorch/detectron2
RUN cd repositories/bottom-up-attention.pytorch && python setup.py build develop && cd /proyectos/uam_vqa
RUN pip install pycocotools
RUN pip install opencv-python
RUN pip install jupyter
RUN cd repositories/apex && python setup.py install && cd /proyectos/uam_vqa
RUN pip install ray
RUN pip install boto3
RUN pip install requests

RUN apt-get update
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid
RUN apt-get install ffmpeg libsm6 libxext6  -y
