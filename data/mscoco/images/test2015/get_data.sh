#!/usr/bin/env bash

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1zZrfQ3sF4vcb8W_TDnxijOkifPtr5_aG' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1zZrfQ3sF4vcb8W_TDnxijOkifPtr5_aG" -O ./data/mscoco/images/test2015/test2015.tar.gz && rm -rf /tmp/cookies.txt
tar -xzvf ./data/mscoco/images/test2015/test2015.tar.gz -C ./data/mscoco/images/test2015
rm -R ./data/mscoco/images/test2015/test2015.tar.gz
find ./data/mscoco/images/test2015/test2015/ -name "*.jpg" -exec mv {} ./data/mscoco/images/test2015/ \;
rm -R ./data/mscoco/images/test2015/test2015