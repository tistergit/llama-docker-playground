from huggingface_hub import snapshot_download


def down_from_hf(model):
    # original model 'THUDM/chatglm-6b' quantized 4bit 'THUDM/chatglm-6b-int4' 8bit 'THUDM/chatglm-6b-int8'
    # repos_id = 'THUDM/chatglm-6b'

    hf_map = {
        'chatglm6b': 'THUDM/chatglm-6b',
        'vicuna-7b': 'lmsys/vicuna-7b-delta-v1.1',
        'vicuna-13b': 'eachadea/vicuna-13b-1.1',

    }

    # download_dir='./'+repos_id
    snapshot_download(repo_id=hf_map[model], local_dir='./' + model,
                      repo_type='model', local_dir_use_symlinks="auto")

if __name__ == '__main__':
        down_from_hf('vicuna-13b')