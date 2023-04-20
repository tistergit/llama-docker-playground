#!/bin/sh

docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -p 8080:7860 \
    --rm -it \
    -v `pwd`/models/chatglm-6b:/app/ChatGLM-6B/THUDM/chatglm-6b \
    mirrors.tencent.com/rms/llama_finetune:chatglm python web_demo.py