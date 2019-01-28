#!/bin/bash
arch=$1
pair=$2
highreslang=$(echo $pair|sed -e 's/--/:/g'|cut -d: -f1)
lowreslang=$(echo $pair|sed -e 's/--/:/g'|cut -d: -f2)
python3.7 src/train.py \
    --dataset sigmorphon19task1 \
    --train sample/task1/$pair/$highreslang-train-high sample/task1/$pair/$lowreslang-train-low  \
    --dev sample/task1/$pair/$lowreslang-dev \
    --model model/sigmorphon19/task1/monotag-$arch/$pair --seed 0 \
    --load ~/crosslingual-inflection-baseline/model/sigmorphon19/task1/monotag-hmm/adyghe--kabardian.nll_0.2800.acc_32.0.dist_2.64.epoch_2 \
    --embed_dim 200 --src_hs 400 --trg_hs 400 --dropout 0.4 \
    --src_layer 2 --trg_layer 1 --max_norm 5 \
    --arch $arch --estop 1e-8 --epochs 50 --bs 20 --mono
