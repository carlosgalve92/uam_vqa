#!/usr/bin/env bash

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1c4OvoZSKkK88VJrFJf8jPBGXi9kAAwA_' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1c4OvoZSKkK88VJrFJf8jPBGXi9kAAwA_" -O ./data/mscoco/images/train2014/train2014.tar.gz && rm -rf /tmp/cookies.txt
tar -xzvf ./data/mscoco/images/train2014/train2014.tar.gz -C ./data/mscoco/images/train2014
rm -R ./data/mscoco/images/train2014/train2014.tar.gz
find ./data/mscoco/images/train2014/train2014/ -name "*.jpg" -exec mv {} ./data/mscoco/images/train2014/ \;
rm -R ./data/mscoco/images/train2014/train2014