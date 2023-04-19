docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 \
    --rm -it \
    -v `pwd`/models:/app/alpaca-lora/original-weights \
    -v `pwd`/weights:/app/alpaca-lora/weights \
    -v `pwd`/samples:/app/alpaca-lora/samples \
    mirrors.tencent.com/rms/llama_finetune:v2 bash