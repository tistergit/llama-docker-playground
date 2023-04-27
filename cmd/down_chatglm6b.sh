#!/bin/sh

MODEL_DIR=`pwd`"/models/chatglm-6b/"
cd $MODEL_DIR

TMP_DIR=`mktemp -d`

## down model other file
GIT_LFS_SKIP_SMUDGE=1
git clone --depth=1 https://huggingface.co/THUDM/chatglm-6b $TMP_DIR

cp $TMP_DIR/* $MODEL_DIR

aria2c -x 16 -s 5 -c -i cmd/chatglm6b_links.file -d $MODEL_DIR




