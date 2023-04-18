python -m transformers.models.llama.convert_llama_weights_to_hf \
  --input_dir original-weights/llama \
  --model_size 7B \
  --output_dir weights/hf


python scripts/merge_llama_with_chinese_lora.py \
    --base_model weights/hf \
    --lora_model original-weights/alpaca/chinese_alpaca_lora_7b \
    --output_dir weights/pth

python scripts/merge_llama_with_chinese_lora_to_hf.py \
    --base_model weights/hf \
    --lora_model original-weights/alpaca/chinese_alpaca_lora_7b \
    --output_dir weights/zh-hf


sudo docker run --gpus=all --shm-size 64g -p 7860:7860 -v ${HOME}/.cache:/root/.cache --rm alpaca-lora generate.py \
    --load_8bit \
    --base_model '/data/home/tisteryu/llama-docker-playground/weights/hf' \
    --lora_weights '/data/home/tisteryu/llama-docker-playground/tloen/alpaca-lora-7b'


python scripts/inference_hf.py \
    --base_model weights/hf \
    --lora_model weights/chinese-alpaca-lora-7b \
    --with_prompt \
    --interactive


python generate.py \
    --load_8bit \
    --base_model 'weights/hf' \
    --lora_weights 'weights/chinese-alpaca-lora-7b'
