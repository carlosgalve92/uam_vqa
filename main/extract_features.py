# Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved
# pylint: disable=no-member
"""
TridentNet Training Script.

This script is a simplified version of the training script in detectron2/tools.
"""
import argparse
import os
import sys
import torch
import tqdm
import cv2
import numpy as np
sys.path.append('detectron2')

from detectron2.checkpoint import DetectionCheckpointer
from detectron2.config import get_cfg
from detectron2.engine import DefaultTrainer, default_setup, launch

from utils.extract_utils import get_image_blob
from utils.progress_bar import ProgressBar
from models import add_config
from models.bua.box_regression import BUABoxes

from models.bua.layers.nms import nms
import base64
import csv
csv.field_size_limit(sys.maxsize)

def save_lxmert_features(args, cfg, im_file, im, dataset_dict, boxes, scores, features_pooled, attr_scores=None):
    MIN_BOXES = cfg.MODEL.BUA.EXTRACTOR.MIN_BOXES
    MAX_BOXES = cfg.MODEL.BUA.EXTRACTOR.MAX_BOXES
    CONF_THRESH = cfg.MODEL.BUA.EXTRACTOR.CONF_THRESH
  
    dets = boxes[0] / dataset_dict['im_scale']
    scores = scores[0]
    feats = features_pooled[0]

    max_conf = torch.zeros((scores.shape[0])).to(scores.device)
    for cls_ind in range(1, scores.shape[1]):
            cls_scores = scores[:, cls_ind]
            keep = nms(dets, cls_scores, 0.3)
            max_conf[keep] = torch.where(cls_scores[keep] > max_conf[keep],
                                             cls_scores[keep],
                                             max_conf[keep])
            
    keep_boxes = torch.nonzero(max_conf >= CONF_THRESH).flatten()
    if len(keep_boxes) < MIN_BOXES:
        keep_boxes = torch.argsort(max_conf, descending=True)[:MIN_BOXES]
    elif len(keep_boxes) > MAX_BOXES:
        keep_boxes = torch.argsort(max_conf, descending=True)[:MAX_BOXES]
    image_feat = feats[keep_boxes]
    image_bboxes = dets[keep_boxes]
    image_objects_conf = np.max(scores[keep_boxes].numpy()[:,1:], axis=1)
    image_objects = np.argmax(scores[keep_boxes].numpy()[:,1:], axis=1)
    
    attr_scores = attr_scores[0]
    image_attrs_conf = np.max(attr_scores[keep_boxes].numpy()[:,1:], axis=1)
    image_attrs = np.argmax(attr_scores[keep_boxes].numpy()[:,1:], axis=1)
    item = {
        'img_id': im_file.split('.')[0],
        'img_h': np.size(im, 0),
        'img_w': np.size(im, 1),
        'objects_id': base64.b64encode(image_objects).decode(),
        'objects_conf': base64.b64encode(image_objects_conf).decode(),
        'attrs_id': base64.b64encode(image_attrs).decode(),
        'attrs_conf': base64.b64encode(image_attrs_conf).decode(),
        'num_boxes': len(keep_boxes),            
        'boxes': base64.b64encode(image_bboxes.numpy()).decode(),  # float32
        'features': base64.b64encode(image_feat.numpy()).decode()  # float32
    }

    output_file = os.path.join(args.output_dir, f'{args.prefix_split}_d2obj36.tsv')

    os.makedirs(os.path.dirname(args.output_dir), exist_ok=True)
    with open(output_file, 'a') as tsvfile:
        writer = csv.DictWriter(tsvfile, delimiter='\t', fieldnames=FIELDNAMES)
        writer.writerow(item)

def setup(args):
    """
    Create configs and perform basic setups.
    """
    cfg = get_cfg()
    add_config(args, cfg)
    cfg.merge_from_file(args.config_file)
    cfg.merge_from_list(args.opts)
    cfg.merge_from_list(['MODEL.BUA.EXTRACTOR.MODE', 1])
    cfg.freeze()
    default_setup(cfg, args)
    return cfg

def extract_feat(split_idx, img_list, cfg, args):

    output_file = os.path.join(args.output_dir, f'{args.prefix_split}_d2obj36.tsv')
    
    img_list_aux = [[image_id.split(".")[0], image_id] for image_id in img_list]

    wanted_ids = set([image_id[0] for image_id in img_list_aux])
    found_ids = set()
    if os.path.exists(output_file):
        with open(output_file, 'r') as tsvfile:
            reader = csv.DictReader(tsvfile, delimiter='\t', fieldnames=FIELDNAMES)
            for item in reader:
                found_ids.add(item['img_id'])
    missing = wanted_ids - found_ids

    img_list_aux2 = list(filter(lambda x:x[0] in missing, img_list_aux))
    img_list = [img[1] for img in img_list_aux2]

    num_images = len(img_list)
    print('Number of images on split{}: {}.'.format(split_idx, num_images))

    model = DefaultTrainer.build_model(cfg)
    DetectionCheckpointer(model, save_dir=cfg.OUTPUT_DIR).resume_or_load(
        cfg.MODEL.WEIGHTS, resume=args.resume
    )
    model.eval()

    for idx_im_file in tqdm.tqdm(range(0, num_images)):
        im_file=img_list[idx_im_file]
        im = cv2.imread(os.path.join(args.image_dir, im_file))
        if im is None:
            print(os.path.join(args.image_dir, im_file), "is illegal!")
            continue
        dataset_dict = get_image_blob(im, cfg.MODEL.PIXEL_MEAN)
        # extract roi_features and bbox
        attr_scores = None
        with torch.set_grad_enabled(False):
            boxes, scores, features_pooled, attr_scores = model([dataset_dict])
        boxes = [box.tensor.cpu() for box in boxes]
        scores = [score.cpu() for score in scores]
        features_pooled = [feat.cpu() for feat in features_pooled]
        attr_scores = [attr_score.cpu() for attr_score in attr_scores]
        save_lxmert_features(args, cfg, im_file, im, dataset_dict, boxes, scores, features_pooled, attr_scores)


def main():
    parser = argparse.ArgumentParser(description="PyTorch Object Detection2 Inference")
    parser.add_argument(
        "--config-file",
        default="configs/bua-caffe/extract-bua-caffe-r101.yaml",
        metavar="FILE",
        help="path to config file",
    )

    parser.add_argument('--num-cpus', default=1, type=int, 
                        help='number of cpus to use for ray, 0 means no limit')

    parser.add_argument('--gpus', dest='gpu_id', help='GPU id(s) to use',
                        default='0', type=str)

    parser.add_argument("--mode", default="caffe", type=str, help="bua_caffe, ...")

    parser.add_argument('--extract-mode', default='roi_feats', type=str,
                        help="'roi_feats', 'bboxes' and 'bbox_feats' indicates \
                        'extract roi features directly', 'extract bboxes only' and \
                        'extract roi features with pre-computed bboxes' respectively")

    parser.add_argument('--min-max-boxes', default='min_max_default', type=str, 
                        help='the number of min-max boxes of extractor')

    parser.add_argument('--out-dir', dest='output_dir',
                        help='output directory for features',
                        default="features")

    parser.add_argument('--prefix_split', default="train2014", type=str,
                        help='split data')

    parser.add_argument('--image-dir', dest='image_dir',
                        help='directory with images',
                        default="image")

    parser.add_argument(
        "--resume",
        action="store_true",
        help="whether to attempt to resume from the checkpoint directory",
    )

    parser.add_argument(
        "opts",
        help="Modify config options using the command-line",
        default=None,
        nargs=argparse.REMAINDER,
    )

    arg_list = [
        "--mode", MODE, 
        "--num-cpus", NUM_CPUS,
        "--gpus", GPUS,
        "--extract-mode", EXTRACT_MODE,
        # "--min-max-boxes", MIN_MAX_BOXES,
        "--config-file", CONFIG_FILE,
        "--prefix_split", PREFIX_SPLIT,
        "--image-dir", IMAGE_DIR,
        "--out-dir", OUT_DIR
    ]
    args = parser.parse_args(arg_list)

    cfg = setup(args)

    os.environ['CUDA_VISIBLE_DEVICES'] = args.gpu_id
    num_gpus = len(args.gpu_id.split(','))

    # Extract features.
    imglist = os.listdir(args.image_dir)
    num_images = len(imglist)
    print('Number of images: {}.'.format(num_images))

    img_lists = [imglist[i::num_gpus] for i in range(num_gpus)]

    print('Number of GPUs: {}.'.format(num_gpus))
    extract_feat(0, img_lists[0], cfg, args)

MODE="caffe"
NUM_CPUS = "0"
GPUS = "'0'"
EXTRACT_MODE = "roi_feats"
# MIN_MAX_BOXES = "'36,36'"
CONFIG_FILE = "/home/carlosgalve92/Escritorio/trabajos/final_project_of_master/configs/bottom_up_features/extract-bua-caffe-r101-fix36.yaml"
PREFIX_SPLIT = "test2015" # train2014, val2014, test2015, prueba
IMAGE_DIR = f"/home/carlosgalve92/Escritorio/trabajos/final_project_of_master/data/mscoco/images/{PREFIX_SPLIT}"
OUT_DIR = "/home/carlosgalve92/Escritorio/trabajos/final_project_of_master/output"
FIELDNAMES = ["img_id", "img_h", "img_w", "objects_id", "objects_conf", "attrs_id", "attrs_conf", "num_boxes", "boxes", "features"]

if __name__ == "__main__":
    main()