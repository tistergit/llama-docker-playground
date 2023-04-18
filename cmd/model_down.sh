#!/bin/sh

MODEL_BASE_URL="https://agi.gpt4.org/llama/LLaMA/"

MODEL_DIR=`pwd`"/models"

usage() {
  echo "Usage: $0 [ -m MODEL ] , it's : 7b 13b 30b 30b 65b"
  exit 1
}

dl_comm() {
	wget -c ${MODEL_BASE_URL}tokenizer.model -O ${MODEL_DIR}/tokenizer.model
	wget -c ${MODEL_BASE_URL}tokenizer_checklist.chk -O ${MODEL_DIR}/tokenizer_checklist.chk
}

dl_7b() {
	wget -c ${MODEL_BASE_URL}7B/consolidated.00.pth -O ${MODEL_DIR}/7B/consolidated.00.pth
	wget -c ${MODEL_BASE_URL}7B/params.json -O ${MODEL_DIR}/7B/params.json
	wget -c ${MODEL_BASE_URL}7B/checklist.chk -O ${MODEL_DIR}/7B/checklist.chk
} 

dl_13b() {
	wget -c ${MODEL_BASE_URL}13B/consolidated.00.pth -O ${MODEL_DIR}/13B/consolidated.00.pth
	wget -c ${MODEL_BASE_URL}13B/consolidated.01.pth -O ${MODEL_DIR}/13B/consolidated.01.pth
	wget -c ${MODEL_BASE_URL}13B/params.json -O ${MODEL_DIR}/13B/params.json
	wget -c ${MODEL_BASE_URL}13B/checklist.chk -O ${MODEL_DIR}/13B/checklist.chk
}

dl_30b() {
	wget -c ${MODEL_BASE_URL}30B/consolidated.00.pth -O ${MODEL_DIR}/30B/consolidated.00.pth
	wget -c ${MODEL_BASE_URL}30B/consolidated.01.pth -O ${MODEL_DIR}/30B/consolidated.01.pth
	wget -c ${MODEL_BASE_URL}30B/consolidated.02.pth -O ${MODEL_DIR}/30B/consolidated.02.pth
	wget -c ${MODEL_BASE_URL}30B/consolidated.03.pth -O ${MODEL_DIR}/30B/consolidated.03.pth
	wget -c ${MODEL_BASE_URL}30B/params.json -O ${MODEL_DIR}/30B/params.json
	wget -c ${MODEL_BASE_URL}30B/checklist.chk -O ${MODEL_DIR}/30B/checklist.chk

}

dl_65b() {
	wget -c ${MODEL_BASE_URL}65B/consolidated.00.pth -O ${MODEL_DIR}/65B/consolidated.00.pth
	wget -c ${MODEL_BASE_URL}65B/consolidated.01.pth -O ${MODEL_DIR}/65B/consolidated.01.pth
	wget -c ${MODEL_BASE_URL}65B/consolidated.02.pth -O ${MODEL_DIR}/65B/consolidated.02.pth
	wget -c ${MODEL_BASE_URL}65B/consolidated.03.pth -O ${MODEL_DIR}/65B/consolidated.03.pth
	wget -c ${MODEL_BASE_URL}65B/consolidated.04.pth -O ${MODEL_DIR}/65B/consolidated.04.pth
	wget -c ${MODEL_BASE_URL}65B/consolidated.05.pth -O ${MODEL_DIR}/65B/consolidated.05.pth
	wget -c ${MODEL_BASE_URL}65B/consolidated.06.pth -O ${MODEL_DIR}/65B/consolidated.06.pth
	wget -c ${MODEL_BASE_URL}65B/consolidated.07.pth -O ${MODEL_DIR}/65B/consolidated.07.pth
	wget -c ${MODEL_BASE_URL}65B/params.json -O ${MODEL_DIR}/65B/params.json
	wget -c ${MODEL_BASE_URL}65B/checklist.chk -O ${MODEL_DIR}/65B/checklist.chk
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
esac


