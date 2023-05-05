#!/bin/sh

DOCKER_BUILDKIT=0 docker build -t mirrors.tencent.com/rms/llama_finetune:v2 . -f docker/Dockerfile.lora-finetune