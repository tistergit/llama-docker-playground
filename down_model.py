#!/usr/bin/env python3


import requests
import os
import time
import sys

from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor, Future, as_completed, wait
from multiprocessing import cpu_count
from urllib.request import urlopen
from huggingface_hub import snapshot_download
import argparse


MODEL_BASE_URL = "https://mirrors.tencent.com/repository/generic/llm_repo/chatglm-6b/"
MODEL_DIR = os.path.join(os.path.dirname(
    __file__), 'models', 'chatglm-6b')

THREAD_COUNT = 4

chatglm6b_files = [
    'config.json',
    'configuration_chatglm.py',
    'ice_text.model',
    'LICENSE',
    'modeling_chatglm.py',
    'MODEL_LICENSE',
    'pytorch_model-00001-of-00008.bin',
    'pytorch_model-00002-of-00008.bin',
    'pytorch_model-00003-of-00008.bin',
    'pytorch_model-00004-of-00008.bin',
    'pytorch_model-00005-of-00008.bin',
    'pytorch_model-00006-of-00008.bin',
    'pytorch_model-00007-of-00008.bin',
    'pytorch_model-00008-of-00008.bin',
    'pytorch_model.bin.index.json',
    'quantization.py',
    'README.md',
    'tokenization_chatglm.py',
    'tokenizer_config.json'
]

chatglm130b_files = [
    '49300/mp_rank_04_model_states.pt',
    '49300/mp_rank_00_model_states.pt',
    '49300/mp_rank_06_model_states.pt',
    '49300/mp_rank_02_model_states.pt',
    '49300/mp_rank_07_model_states.pt',
    '49300/mp_rank_05_model_states.pt',
    '49300/mp_rank_01_model_states.pt',
    '49300/mp_rank_03_model_states.pt',
    'latest'
]

llama_7B_files = [
    'checklist.chk',
    'consolidated.00.pth',
    'params.json'
]

vicuna_7b_files = [
    'checklist.chk',
]


def download_file(url, dst_file):
    print("------", "Start download with requests")
    name = url.split("/")[-1]
    resp = requests.get(url, stream=True)
    content_size = int(resp.headers['Content-Length']) / 1024  # 确定整个安装包的大小

    print("File path:%s, content_size:%s" % (dst_file, content_size))
    with open(dst_file, "wb") as file:
        print("\rFile %s, total size is: %s" % (name, content_size))
        for data in tqdm(iterable=resp.iter_content(1024), total=content_size, unit='k', desc=name):
            file.write(data)
    print("%s download ok" % name)


def down_from_tencent():
    executor = ThreadPoolExecutor(max_workers=THREAD_COUNT)  # 线程池设置,最多同时跑8个线程
    for file in chatglm6b_files:
        url = os.path.join(MODEL_BASE_URL, file)
        dst_file = os.path.join(MODEL_DIR, file)
        print("dst file : ", dst_file)
        args = [url, dst_file,]
        tasks = [executor.submit(lambda p:download_file(*p), args)]
    wait(tasks)


def down_from_hf(model_id):
    snapshot_download(repo_id=model_id, local_dir='./' + model_id,
                      repo_type='model', local_dir_use_symlinks="auto")


if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    parser.add_argument(
        "-s", "--source", help="hf or tx , default : tx ", default='hf')
    parser.add_argument(
        "-m", "--model", help="model type,chatglm130b chatglm6b,llama7B llama13B")

    args = parser.parse_args()

    if args.source == 'tx':
        down_from_tencent()
    else:
        down_from_hf(args.model)
