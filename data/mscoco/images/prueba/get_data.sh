#!/usr/bin/env bash

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1UFy0x1ZLZNeEpG7meMQB_SPzAtSwQA7o' -O ./data/mscoco/images/prueba/prueba.tar.gz
tar -xzvf ./data/mscoco/images/prueba/prueba.tar.gz -C ./data/mscoco/images/prueba
rm -R ./data/mscoco/images/prueba/prueba.tar.gz
find ./data/mscoco/images/prueba/prueba/ -name "*.jpg" -exec mv {} ./data/mscoco/images/prueba/ \;
rm -R ./data/mscoco/images/prueba/prueba