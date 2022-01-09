# uam_vqa
This repository contain code of VQA algorithm (LXMERT) and code for extract data in correct format

# To test that everything is working correctly:
```
# run get_config_test.sh
source source get_config_test.sh
```

# To test with new images:
```
# Run get_config_test.sh if not done before.

# Delete images from /projects/uam_vqa/data/images/raw

# Copy new image from which you want to extract the features to the path "/projects/uam_vqa/data/images/raw" using the docker volume.

# For simplicity, change the name of the new image to "COCO_train2014_00000030306661.jpg".

# Run "./main/extract_features.py", which will generate the file "raw_d2obj36.tsv" in the path "/projects/uam_vqa/data/edBB/images/features", which will need to be moved to the path "/projects/uam_vqa/data/mscoco_imgfeat" and renamed to "test2015_obj36. tsv" which will overwrite the file "test2015_obj36.tsv" that was in that path.

# Modify the file "test.json" (located in the path "/projects/uam_vqa/data/vqa") by setting the question to be asked in the "sent" field.

# Run "./main/lxmert_vqa.py", which will generate the output in the file "test_predict.json" in the path "/projects/uam_vqa/output/lxmert/edBB/test".
```