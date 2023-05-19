#!/bin/sh

DOCKER_BUILDKIT=0 docker build -t mirrors.tencent.com/rms/finetuning:chatglm6b . -f docker/Dockerfile.chatglm6b