docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 \
    --rm -it \
    -v /data/models:/app/alpaca-lora/original-weights \
    -v `pwd`/weights:/app/alpaca-lora/weights \
    soulteary/llama:alpaca-lora-finetune bash