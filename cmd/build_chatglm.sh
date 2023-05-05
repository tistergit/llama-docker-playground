#!/bin/sh

DOCKER_BUILDKIT=0 docker build -t mirrors.tencent.com/rms/llama_finetune:chatglm . -f docker/Dockerfile.chatglm