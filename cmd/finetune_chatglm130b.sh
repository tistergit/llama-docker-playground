#!/bin/sh

docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 \
    --rm -it \
    -v `pwd`/models:/app/models \
    mirrors.tencent.com/rms/finetuning:chatglm130b /bin/bash