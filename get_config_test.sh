source data/vqa/get_data.sh
source models/bottom_up_features/get_model.sh
cp ./data/edBB/images/features/*.tsv ./data/mscoco_imgfeat/
mv ./data/vqa/test.json ./data/vqa/test_repo.json
cp ./data/edBB/vqa/test.json ./data/vqa/
source models/lxmert/best_fine_tuned_vqa_tfm/get_model.sh
