#!/usr/bin/env bash

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=18jbteHg5277B5Zrffh5A6GToB3o90FXV' -O ./data/lxmert/val2014_obj36.tsv
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1J1juFS7uPDr0lruRtQf2JTZfCn9YaDl2' -O ./data/lxmert/train2014_obj36.tsv
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1ITOeWCLEmO_PW9FNUKVZe8etSthconUg' -O ./data/lxmert/test2015_obj36.tsv