## ChatGLM-6B 基础模型Fine-tuning Mini版

该项目通过Docker镜像为大家提供一个整合好的Fine-tuning环境，使用它可以对ChatGLM-6B模型进行finetune。

### 前置条件
已经安装好Docker

验证Docker是否正常运行

```shell
docker run hello-world
```

### 下载代码

```shell
$ git clone https://git.woa.com/tisteryu/llama-docker-playground.git

or 

$ git clone https://github.com/tistergit/llama-docker-playground.git
```

### 拉取Docker镜像
   由于外网dockerhub网速慢，所以我直接把镜像推到公司内镜像仓库，大大提升镜像下载速度
   ```shell
   $ docker pull mirrors.tencent.com/rms/chatglm6b:efinetuning
   ```

### 下载原始ChatGLM-6B模型
   
   ```shell
   cmd/down_model.sh -m chatglm6b
   ```

   提示：不是每次都要重新下载原始模型文件，只需要下载一次即可，成功下载后，模型文件在models目录下，如下图：
   ```
   (base) [root@11-181-233-20 models]# tree chatglm-6b/
      chatglm-6b/
      ├── config.json
      ├── configuration_chatglm.py
      ├── ice_text.model
      ├── LICENSE
      ├── modeling_chatglm.py
      ├── MODEL_LICENSE
      ├── pytorch_model-00001-of-00008.bin
      ├── pytorch_model-00002-of-00008.bin
      ├── pytorch_model-00003-of-00008.bin
      ├── pytorch_model-00004-of-00008.bin
      ├── pytorch_model-00005-of-00008.bin
      ├── pytorch_model-00006-of-00008.bin
      ├── pytorch_model-00007-of-00008.bin
      ├── pytorch_model-00008-of-00008.bin
      ├── pytorch_model.bin.index.json
      ├── quantization.py
      ├── README.md
      ├── tokenization_chatglm.py
      └── tokenizer_config.json
   ```

### 微调方法

目前支持了以下几种微调方法：

- [LoRA](https://arxiv.org/abs/2106.09685)
  - 仅微调低秩适应器。
- [P-Tuning V2](https://github.com/THUDM/P-tuning-v2)
  - 仅微调前缀编码器。
- [Freeze](https://arxiv.org/abs/2012.14913)
  - 仅微调后几层的全连接层。

### Fine-tune(参数微调)
   
   首先，进入镜像内环境：
   ```shell
   cmd/finetune_chatglm_v2.sh
   ```
   然后在镜像内，执行如下脚本，启动finetune，需要较长时间，如果担心控制台中断，可以在进行镜像前，启动一个tmux会话窗口。
   如果机器上只有两块T4显卡，可能会出现显存不足的情况，可以考虑对模型进行量化后微调，当然这样会对模型效果带来一定折损，比如：--quantization_bit 8 。其它参数说明：
  
  - dataset: 训练数据集名称，详见[训练数据集](#训练数据集)
  - finetuning_type: 微调方法，lora or  p_tuning or freeze
  - output_dir: 生成的checkpoint目录，已映射到docker外volume上

```bash
   CUDA_VISIBLE_DEVICES=0,1 python src/finetune.py \
    --do_train \
    --dataset alpaca_gpt4_zh \
    --finetuning_type lora \
    --output_dir checkpoint \
    --per_device_train_batch_size 4 \
    --gradient_accumulation_steps 4 \
    --lr_scheduler_type cosine \
    --logging_steps 10 \
    --save_steps 1000 \
    --learning_rate 5e-5 \
    --num_train_epochs 1.0 \
    --fp16 \
    --quantization_bit 8
```


### 训练数据集
关于数据集文件的格式，请参考 data/example_dataset 文件夹的内容。构建自定义数据集时，既可以使用单个 .json 文件，也可以使用一个数据加载脚本和多个文件。

注意：使用自定义数据集时，请更新 data/dataset_info.json 文件，该文件的格式请[参考](https://github.com/hiyouga/ChatGLM-Efficient-Tuning/tree/main/data)

  enjoy it ~~~