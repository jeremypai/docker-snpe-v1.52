# docker-snpe-v1.52
Docker for SNPE v1.52 Development

## SNPE v1.52 Prerequisites
+ Linux: Ubuntu 18.04
+ Python: python 3.6
+ Types of input data: float32 with *.raw type
+ Android NDK: r19c (You could search [here](https://github.com/android/ndk/wiki/Unsupported-Downloads) to find the right NDK)
+ SNPE v1.52 files: You have to get this from Qualcomm page

## Setup Docker Container
1. Create docker image: `tasks: Create snpe:v1.52 docker image`
2. Extract thirdparty archives: `unzip android-ndk-r19c-linux-x86_64.zip` and `unzip snpe-1.52.0.zip`
3. Get execute permission of SNPE tool binaries: `chmod +x snpe-1.52.0.2724/bin/envsetup.sh`
4. Run docker image as a container: `tasks: Run snpe:v1.52 as a container`

## Prerequisites (In Docker Container)
+ Setup environment: `source scripts/setup_environment.sh`
+ Use `create_raw_list.py` to create `raw_list.txt` for model quantization:
```
// create raw_list.txt with absolute path written in file
$ python3 scripts/create_raw_list.py -i <path/to/data/folder> -o <path/to/raw_list.txt> -e *.raw

// create target_raw_list.txt with relative path written in file
$ python3 scripts/create_raw_list.py -i <path/to/data/folder> -o <path/to/target_raw_list.txt> -e *.raw -r
```

## Convert Model (In Docker Container)
+ Convert to dlc-typed model (This image only support onnx conversion):
```
$ snpe-onnx-to-dlc -i <path/to/model.onnx> -o <path/to/model.dlc>
```
+ If we need to run model on DSP or AIP (ex. NPU) runtime, we need to quantize dlc model:
```
$ snpe-dlc-quantize --input_dlc <path/to/model.dlc> --input_list <path/to/raw_list.txt> --output_dlc <path/to/model_quantize.dlc> --enable_hta --hta_partitions <layers to run on HTA runtime ex. 0-40>
```

## Model Analysis (In Docker Container)
+ `snpe-dlc-viewer`: This command could create a visualized html file to find out which runtime is used in each layer
```
$ snpe-dlc-viewer -i <path/to/model.dlc> -s <path/to/model.html>
```
+ `snpe_bench.py`: This python script could create an analysis about performance metrics of model (NOTE: but you need to pass `--device` or `--privileged` to make docker have the permission to access android device)
```
$ python3 snpe_bench.py -c <path/to/config.json> -a
```