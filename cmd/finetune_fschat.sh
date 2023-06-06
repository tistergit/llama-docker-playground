#!/bin/sh

docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -p 8000:8000 -p 8080:8080 \
    --rm -it \
    -v `pwd`/models:/app/models \
    -v `pwd`/weights:/app/alpaca-lora/weights \
    -v `pwd`/samples:/app/alpaca-lora/samples \
    mirrors.tencent.com/rms/fast_transformer:v1 bash