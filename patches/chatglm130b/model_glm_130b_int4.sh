MODEL_TYPE="glm-130b"
CHECKPOINT_PATH="/app/models/chatglm-130b-int4-mp8"
MP_SIZE=4
MODEL_ARGS="--model-parallel-size ${MP_SIZE} \
            --num-layers 70 \
            --hidden-size 12288 \
            --inner-hidden-size 32768 \
            --vocab-size 150528 \
            --num-attention-heads 96 \
            --max-sequence-length 2048 \
            --tokenizer-type icetk-glm-130B \
            --layernorm-order post \
            --quantization-bit-width 4 \
            --load ${CHECKPOINT_PATH} \
            --from-quantized-checkpoint \
            --skip-init \
            --fp16"