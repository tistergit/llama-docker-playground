## ChatGLM-6B 相关模型的Fine-tuning

该项目通过Docker镜像为大家提供一个整合好的Fine-tuning环境，使用它可以对ChatGLM-6B模型进行finetune。
如果你发现默认镜像不符合你的要求，也可以在基础dockerfile上更新，构建适合你的镜像


### 前置条件
已经安装好Docker

验证Docker是否正常运行

```shell
docker run hello-world
```

### 构建自己的镜像（可选）

1. 编辑 docker/Dockerfile.chatglm-finetune 文件
2. 构建镜像
   ```shell
   cmd/build_image4chatglm.sh
   ```
3. PUSH镜像到仓库（可选）

### 启动chatglm推理服务

1. pull镜像
   由于外网dockerhub网速慢，所以我直接把镜像推到公司内镜像仓库，大大提升镜像下载速度
   ```shell
    docker pull mirrors.tencent.com/rms/llama_finetune:chatglm
   ```

2. 下载原始ChatGLM-6B模型
   
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
3. 启动推理服务（web chat)
   ```bash
   ./cmd/generate_chatglm.sh
   ```
   打开浏览器，输入服务器IP+8080端口即可访问
   ![推理web窗口](./assets/image-1.png)


### Fine-tune(参数微调)
   [原文档参考](https://github.com/THUDM/ChatGLM-6B/tree/main/ptuning)

1. 获取镜像
   获取Docker镜像有两种方式：获取已有镜像和构建自己的Docker镜像（如果现有镜像不能满足需求）
   - 拉取现有镜像：
      ```shell
      docker pull mirrors.tencent.com/rms/llama_finetune:chatglm
      ```
   - 构建自己的镜像:
      编辑 docker/Dockerfile.chatglm 文件，然后执行以下命令:
      ```shell
      ./cmd/build_image4chatglm.sh
      ```

2. 下载数据集
   chatglm官方的提供一个数据集示例，ADGEN 数据集任务为根据输入（content）生成一段广告词（summary）。
   ```
   {
      "content": "类型#上衣*版型#宽松*版型#显瘦*图案#线条*衣样式#衬衫*衣袖型#泡泡袖*衣款式#抽绳",
      "summary": "这件衬衫的款式非常的宽松，利落的线条可以很好的隐藏身材上的小缺点，穿在身上有着很好的显瘦效果。领口装饰了一个可爱的抽绳，漂亮的绳结展现出了十足的个性，配合时尚的泡泡袖型，尽显女性甜美可爱的气息。"
   }
   ```
   快捷下载脚本：
   ```shell
   cmd/down_samples.sh -m adgen
   ```
   成功下载后，samples目录下会存在以下文件：
   ```
   (base) [root@11-181-233-20 samples]# tree AdvertiseGen/
   AdvertiseGen/
   ├── dev.json
   └── train.json

   0 directories, 2 files
   ```

3. Finetune
   首先，进入镜像内环境：
   ```shell
   cmd/finetune_chatglm.sh
   ```
   然后在镜像内，执行如下脚本，启动finetune，需要较长时间，如果担心控制台中断，可以在进行镜像前，启动一个tmux会话窗口。
   如果机器上只有两块T4显卡，采用fp16会出现显存不足的情况，需要在ds_train_finetune.sh文件的最后，加上一行：--quantization_bit 4，同时把 --num_gpus=4 改成 --num_gpus=2 。
   ```shell
   bash ds_train_finetune.sh
   ```

  enjoy it ~~~