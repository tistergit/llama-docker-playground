#!/bin/sh

MODEL_BASE_URL="https://mirrors.tencent.com/repository/generic/llm_repo/"

MODEL_DIR=`pwd`"/models"

RETRY=3

usage() {
  echo "Usage: $0 [ -m MODEL ] , it's : adgen"
  exit 1
}


dl_adgen() {
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/7B/consolidated.00.pth -O ${MODEL_DIR}/7B/consolidated.00.pth
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/7B/params.json -O ${MODEL_DIR}/7B/params.json
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/llama/7B/checklist.chk -O ${MODEL_DIR}/7B/checklist.chk
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

case "${model}" in
	adgen) dl_adgen;;
esac


