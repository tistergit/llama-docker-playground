#!/bin/sh

DOCKER_BUILDKIT=0 docker build -t mirrors.tencent.com/rms/finetuning:chatglm130b . -f docker/Dockerfile.chatglm130b