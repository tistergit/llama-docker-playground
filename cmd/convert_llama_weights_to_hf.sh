#!/bin/sh
python -m transformers.models.llama.convert_llama_weights_to_hf \
  --input_dir original-weights \
  --model_size 7B \
  --output_dir weights