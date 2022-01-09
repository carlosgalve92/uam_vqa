#!/usr/bin/env bash

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1V6G8KrJmRsqGLFt5M3mSjfdUSbfdcsGg' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1V6G8KrJmRsqGLFt5M3mSjfdUSbfdcsGg" -O ./data/vqa/train.json && rm -rf /tmp/cookies.txt
#wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1V6G8KrJmRsqGLFt5M3mSjfdUSbfdcsGg' -O ./data/vqa/train.json
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1psllZ-2MF52bWmuM9QjomXEE1hq2mtS-' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1psllZ-2MF52bWmuM9QjomXEE1hq2mtS-" -O ./data/vqa/test.json && rm -rf /tmp/cookies.txt
#wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1psllZ-2MF52bWmuM9QjomXEE1hq2mtS-' -O ./data/vqa/test.json
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1L0A8HoXZN8NfJudwbm_jpDuotWams4cy' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1L0A8HoXZN8NfJudwbm_jpDuotWams4cy" -O ./data/vqa/nominival.json && rm -rf /tmp/cookies.txt
#wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1L0A8HoXZN8NfJudwbm_jpDuotWams4cy' -O ./data/vqa/nominival.json
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1aMqTJ0J-Wp3BXPafy_NPCpmf-TiGUhE9' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1aMqTJ0J-Wp3BXPafy_NPCpmf-TiGUhE9" -O ./data/vqa/minival.json && rm -rf /tmp/cookies.txt
#wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1aMqTJ0J-Wp3BXPafy_NPCpmf-TiGUhE9' -O ./data/vqa/minival.json
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1pXglKQ1Can7cdEEB8viheSm7xvp89W6x' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1pXglKQ1Can7cdEEB8viheSm7xvp89W6x" -O ./data/vqa/trainval_ans2label.json && rm -rf /tmp/cookies.txt
#wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1pXglKQ1Can7cdEEB8viheSm7xvp89W6x' -O ./data/vqa/trainval_ans2label.json
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1_MsU6tibFhHbna1_0g65N_JRaCULk1aR' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1_MsU6tibFhHbna1_0g65N_JRaCULk1aR" -O ./data/vqa/trainval_label2ans.json && rm -rf /tmp/cookies.txt
#wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1_MsU6tibFhHbna1_0g65N_JRaCULk1aR' -O ./data/vqa/trainval_label2ans.json