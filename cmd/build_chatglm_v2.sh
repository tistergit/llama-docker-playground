#!/bin/sh

DOCKER_BUILDKIT=0 docker build -t mirrors.tencent.com/rms/chatglm6b:efinetuning . -f docker/Dockerfile.glmtuning