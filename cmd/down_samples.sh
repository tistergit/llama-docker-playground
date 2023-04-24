#!/bin/sh

MODEL_BASE_URL="https://mirrors.tencent.com/repository/generic/llm_repo/"

MODEL_DIR=`pwd`"/samples/"

RETRY=3

usage() {
  echo "Usage: $0 [ -m MODEL ] , it's : adgen"
  exit 1
}


dl_adgen() {
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/samples/adgen/dev.json -O ${MODEL_DIR}/AdvertiseGen/dev.json
	wget -c -t ${RETRY} ${MODEL_BASE_URL}/samples/adgen/train.json -O ${MODEL_DIR}/AdvertiseGen/train.json
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


