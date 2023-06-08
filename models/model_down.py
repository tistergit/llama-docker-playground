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
import logging

MODEL_URL_PREFIX = "https://mirrors.tencent.com/repository/generic/llm_repo/"


MODEL_DIR =os.path.dirname(__file__)

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

models_files = {
    'chatglm-6b': chatglm6b_files,
    'chatglm-130b': chatglm130b_files,
    'llama': {
        'common': [
            'tokenizer.model',
            'tokenizer_checklist.chk'
        ],
        '7B': [
            'checklist.chk',
            'consolidated.00.pth',
            'params.json'
        ],
        '13B': [
            'consolidated.00.pth',
            'consolidated.01.pth',
            'params.json',
            'checklist.chk']

    }
}

vicuna_7b_files = [
    'checklist.chk',
]


def download_file(url, dst_file):
    logging.info(
        "=== Start download with requests , url: %s , dst_file: %s === " % (url, dst_file))
    name = url.split("/")[-1]
    resp = requests.get(url, stream=True)
    logging.info("resp.status_code: %s" % resp.status_code)
    content_size = int(resp.headers['Content-Length']) / 1024  # 确定整个安装包的大小
    
    ## 目录不存在，创建目录
    if not os.path.exists(os.path.dirname(dst_file)):
        os.makedirs(os.path.dirname(dst_file))

    print("File path:%s, content_size:%s" % (dst_file, content_size))
    with open(dst_file, "wb") as file:
        print("\rFile %s, total size is: %s" % (name, content_size))
        for data in tqdm(iterable=resp.iter_content(1024), total=content_size, unit='k', desc=name):
            file.write(data)
    print("%s download ok" % name)


def llama_common():
    files = []
    for file in models_files['llama']['common']:
        url = os.path.join(MODEL_URL_PREFIX, 'llama/', file)
        dst_file = os.path.join(MODEL_DIR, 'llama/', file)
        logging.info("url : %s , dst_file : %s" % (url, dst_file))
        files.append((url, dst_file))
    return files

def down_from_tencent(model, llama_id):
    executor = ThreadPoolExecutor(max_workers=THREAD_COUNT)
    down_files = []
    if model == 'llama':
        down_files.append(llama_common())
        url_base = os.path.join(MODEL_URL_PREFIX, 'llama/', llama_id)
        for file in models_files['llama'][llama_id]:
            dst_file = os.path.join(MODEL_DIR, 'llama/', llama_id,file)
            file_url = os.path.join(url_base, file)
            down_files.append((file_url,dst_file))
    else:
        for file in models_files[model]:
            file_url = os.path.join(MODEL_URL_PREFIX, model, file)
            dst_file = os.path.join(MODEL_DIR, model, file)
            down_files.append((file_url, dst_file))

    logging.info("down_files : %s" % down_files)


    for url, dst_file in down_files:
        logging.info("url : %s , dst_file : %s" % (url, dst_file))
        args = [url, dst_file,]
        tasks = [executor.submit(lambda p:download_file(*p), args)]
    wait(tasks)


def down_from_hf(model_id):
    snapshot_download(repo_id=model_id, local_dir='./' + model_id,
                      repo_type='model', local_dir_use_symlinks="auto")


if __name__ == '__main__':

    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s [%(levelname)s] %(message)s",
        handlers=[
            logging.FileHandler("downlog.log"),
            logging.StreamHandler()
        ]
    )

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-s", "--source", help="hf or tx , default : tx ")
    parser.add_argument(
        "-m", "--model", help="model type,chatglm-130b chatglm-6b,llama")
    parser.add_argument(
        "-l", "--llama_id", help="llama model id: 7B 13B 30B 65B, default : 7B", default='7B')
    args = parser.parse_args()

    if args.source == 'tx':
        down_from_tencent(args.model, args.llama_id)
    elif args.source == 'hf':
        down_from_hf(args.model)

    if not args.model:
        parser.print_help()
