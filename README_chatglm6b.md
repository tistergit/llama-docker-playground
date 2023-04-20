## ChatGLM-6B 相关模型的Finetune

该项目通过Docker镜像为大家提供一个整合好的finetune环境，使用它可以对ChatGLM-6B模型进行finetune。
如果你发现默认镜像不符合你的要求，也可以在基础dockerfile上更新，构建适合你的镜像


### 前置条件
已经安装好Docker和cuda驱动

验证Docker是否正常运行

```shell
docker run hello-world
```

验证cuda驱动正确安装
```shel
nvidia-smi
```

输出示例如下
```
Wed Apr 19 12:14:17 2023       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 525.105.17   Driver Version: 525.105.17   CUDA Version: 12.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla T4            On   | 00000000:00:09.0 Off |                    0 |
| N/A   30C    P8     8W /  70W |      2MiB / 15360MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
|   1  Tesla T4            On   | 00000000:00:0A.0 Off |                    0 |
| N/A   31C    P8     9W /  70W |      2MiB / 15360MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
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
3. 转换模型格式
  上面下载的LLaMA模型是PyTorch格式（.pth)，通过执行下面的命令，将权重从 PyTorch 检查点转换为与transformer兼容的格式，这样就可以使用transformer进行finetune了。下两种方式二选一即可：
  提示：针对同一模型，如：7B，只需要转换一次即可，转换后hf模型文件放在weights目录中。
  - 容器外命令：

    ```shell

    docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 \
    --rm -it \
    -v `pwd`/models:/app/alpaca-lora/original-weights \
    -v `pwd`/weights:/app/alpaca-lora/weights \
    -v `pwd`/samples:/app/alpaca-lora/samples \
    mirrors.tencent.com/rms/llama_finetune:v2 \
    /app/alpaca-lora/convert_llama_weights_to_hf.sh

    ```

  - 容器内：
    先通过以下命令进入容器
    ```shell
    cmd/finetune_shell.sh
    ```
    再在容器内执行命令，如果是非7B，改变 model_size 这个参数即可
    ```shell

    python -m transformers.models.llama.convert_llama_weights_to_hf \
      --input_dir original-weights \
      --model_size 7B \
      --output_dir weights

    ```

4. 准备样本数据
   样本数据放在samples目录下，finetune.py 脚本默认读取 alpaca_data_cleaned.json 这个文件的内容，如果是其它文件名，改一下finetune.py文件内容即可

5. finetune
   先通过以下命令进入容器
    ```shell
    cmd/finetune_shell.sh
    ```
    再在容器内执行命令:
    ```shell
    python finetune.py
    ```
  然后就是漫长的等待，等待它训练结束

  enjoy it ~~~