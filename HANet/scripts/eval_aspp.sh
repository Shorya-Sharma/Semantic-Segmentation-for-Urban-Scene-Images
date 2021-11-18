#!/usr/bin/env bash
echo "Running inference on" ${1}
echo "Saving Results :" ${2}
python -m torch.distributed.launch --nproc_per_node=4 eval.py \
    --dataset cityscapes \
    --arch network.deepv3.DeepR101V3PlusD_HANet \
    --inference_mode sliding \
    --scales 0.5,1.0,2.0 \
    --split val \
    --cv_split 0 \
    --ckpt_path ${2} \
    --snapshot ${1} \
    --pos_rfactor 8 \
    --hanet 1 1 1 1 0 \
    --hanet_set 3 32 3 \
    --hanet_pos 2 1 \
    --dropout 0.1 \
    --aux_loss \
    # --dump_images \
