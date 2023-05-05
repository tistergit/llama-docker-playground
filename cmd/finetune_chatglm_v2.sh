#!/bin/sh

docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -p 8080:7860 \
    --rm -it \
    -v `pwd`/models/chatglm-6b:/app/ChatGLM-Efficient-Tuning/THUDM/chatglm-6b \
    -v `pwd`/weights:/app/ChatGLM-Efficient-Tuning/checkpoint \
    -v `pwd`/samples:/app/ChatGLM-Efficient-Tuning/samples \
    mirrors.tencent.com/rms/chatglm6b:efinetuning /bin/bash