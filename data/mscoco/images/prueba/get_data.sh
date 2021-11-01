#!/usr/bin/env bash

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1G1dJSHDFKBFltmhluDeq-bTKOqUDQ4vA' -O ./data/mscoco/images/prueba/prueba.tar.gz
tar -xzvf ./data/mscoco/images/prueba/prueba.tar.gz -C ./data/mscoco/images/prueba
rm -R ./data/mscoco/images/prueba/prueba.tar.gz
mv ./data/mscoco/images/prueba/prueba/* ./data/mscoco/images/prueba/
rm -R ./data/mscoco/images/prueba/prueba