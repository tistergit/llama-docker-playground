#!/bin/sh

MODEL_BASE_URL="https://mirrors.tencent.com/repository/generic/llm_repo/"

MODEL_DIR=`pwd`"/models"

RETRY=3

usage() {
  echo "Usage: $0 [ -m MODEL ] , it's : 7b 13b 30b 30b 65b chatglm6b"
  exit 1
}

dl_comm() {
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/tokenizer.model -O ${MODEL_DIR}/tokenizer.model
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/tokenizer_checklist.chk -O ${MODEL_DIR}/tokenizer_checklist.chk
}

dl_7b() {
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/7B/consolidated.00.pth -O ${MODEL_DIR}/7B/consolidated.00.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/7B/params.json -O ${MODEL_DIR}/7B/params.json
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/7B/checklist.chk -O ${MODEL_DIR}/7B/checklist.chk
} 

dl_13b() {
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/13B/consolidated.00.pth -O ${MODEL_DIR}/13B/consolidated.00.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/13B/consolidated.01.pth -O ${MODEL_DIR}/13B/consolidated.01.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/13B/params.json -O ${MODEL_DIR}/13B/params.json
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/13B/checklist.chk -O ${MODEL_DIR}/13B/checklist.chk
}

dl_30b() {
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/30B/consolidated.00.pth -O ${MODEL_DIR}/30B/consolidated.00.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/30B/consolidated.01.pth -O ${MODEL_DIR}/30B/consolidated.01.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/30B/consolidated.02.pth -O ${MODEL_DIR}/30B/consolidated.02.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/30B/consolidated.03.pth -O ${MODEL_DIR}/30B/consolidated.03.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/30B/params.json -O ${MODEL_DIR}/30B/params.json
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/30B/checklist.chk -O ${MODEL_DIR}/30B/checklist.chk

}

dl_65b() {
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/consolidated.00.pth -O ${MODEL_DIR}/65B/consolidated.00.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/consolidated.01.pth -O ${MODEL_DIR}/65B/consolidated.01.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/consolidated.02.pth -O ${MODEL_DIR}/65B/consolidated.02.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/consolidated.03.pth -O ${MODEL_DIR}/65B/consolidated.03.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/consolidated.04.pth -O ${MODEL_DIR}/65B/consolidated.04.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/consolidated.05.pth -O ${MODEL_DIR}/65B/consolidated.05.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/consolidated.06.pth -O ${MODEL_DIR}/65B/consolidated.06.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/consolidated.07.pth -O ${MODEL_DIR}/65B/consolidated.07.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/params.json -O ${MODEL_DIR}/65B/params.json
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/65B/checklist.chk -O ${MODEL_DIR}/65B/checklist.chk
}

dl_chatglm6b() {
	mkdir -p ${MODEL_DIR}/chatglm-6b/
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/ice_text.model  -O ${MODEL_DIR}/chatglm-6b/ice_text.model
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/LICENSE -O ${MODEL_DIR}/chatglm-6b/LICENSE
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/MODEL_LICENSE  -O ${MODEL_DIR}/chatglm-6b/MODEL_LICENSE
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/pytorch_model-00001-of-00008.bin -O ${MODEL_DIR}/chatglm-6b/pytorch_model-00001-of-00008.bin
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/pytorch_model-00002-of-00008.bin -O ${MODEL_DIR}/chatglm-6b/pytorch_model-00002-of-00008.bin
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/pytorch_model-00003-of-00008.bin -O ${MODEL_DIR}/chatglm-6b/pytorch_model-00003-of-00008.bin
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/pytorch_model-00004-of-00008.bin -O ${MODEL_DIR}/chatglm-6b/pytorch_model-00004-of-00008.bin
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/pytorch_model-00005-of-00008.bin -O ${MODEL_DIR}/chatglm-6b/pytorch_model-00005-of-00008.bin
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/pytorch_model-00006-of-00008.bin -O ${MODEL_DIR}/chatglm-6b/pytorch_model-00006-of-00008.bin
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/pytorch_model-00007-of-00008.bin -O ${MODEL_DIR}/chatglm-6b/pytorch_model-00007-of-00008.bin
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-6b/pytorch_model-00008-of-00008.bin -O ${MODEL_DIR}/chatglm-6b/pytorch_model-00008-of-00008.bin
}

dl_chatglm130b() {
	mkdir -p ${MODEL_DIR}/chatglm-130b/
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-130b/glm-130b-sat/49300/mp_rank_00_model_states.pt  -O ${MODEL_DIR}/chatglm-130b/mp_rank_00_model_states.pt
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-130b/glm-130b-sat/49300/mp_rank_01_model_states.pt  -O ${MODEL_DIR}/chatglm-130b/mp_rank_01_model_states.pt
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-130b/glm-130b-sat/49300/mp_rank_02_model_states.pt  -O ${MODEL_DIR}/chatglm-130b/mp_rank_02_model_states.pt
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-130b/glm-130b-sat/49300/mp_rank_03_model_states.pt  -O ${MODEL_DIR}/chatglm-130b/mp_rank_03_model_states.pt
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-130b/glm-130b-sat/49300/mp_rank_04_model_states.pt  -O ${MODEL_DIR}/chatglm-130b/mp_rank_04_model_states.pt
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-130b/glm-130b-sat/49300/mp_rank_05_model_states.pt  -O ${MODEL_DIR}/chatglm-130b/mp_rank_05_model_states.pt
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-130b/glm-130b-sat/49300/mp_rank_06_model_states.pt  -O ${MODEL_DIR}/chatglm-130b/mp_rank_06_model_states.pt
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/chatglm-130b/glm-130b-sat/49300/mp_rank_07_model_states.pt  -O ${MODEL_DIR}/chatglm-130b/mp_rank_07_model_states.pt
}


while getopts m:h flag
do
    case "${flag}" in
        m) model=${OPTARG};;
		h) usage;;
		?) usage;;
    	*) usage;;
    esac
done

echo $model

dl_comm

case "${model}" in
	7b) dl_7b;;
	13b) dl_13b;;
	30b) dl_30b;;
	65b) dl_65b;;
	chatglm6b) dl_chatglm6b;;
	chatglm130b) dl_chatglm130b;;
esac


