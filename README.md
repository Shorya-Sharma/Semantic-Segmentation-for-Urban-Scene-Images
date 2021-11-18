# Semantic Segmentation for Urban-Scene Images

## Environment
We are running our baseline models on AWS EC2 g4dn.12xlarge (4GPUs) instances with Pytorch 1.4.0.

## Dataset
The dataset we are currently using is Cityscapes, you should download the "gtFine_trainvaltest.zip" and "leftImg8bit_trainvaltest.zip" from https://www.cityscapes-dataset.com/ or you can simply run the following commands. You can store the two dataset in a different directory.

```bash
# login in with your cityscapes account
wget --keep-session-cookies --save-cookies=cookies.txt --post-data 'username=yourusername&password=yourpassword&submit=Login' https://www.cityscapes-dataset.com/login/

# download
wget --load-cookies cookies.txt --content-disposition https://www.cityscapes-dataset.com/file-handling/?packageID=1
wget --load-cookies cookies.txt --content-disposition https://www.cityscapes-dataset.com/file-handling/?packageID=3

# unzip
unzip leftImg8bit_trainvaltest.zip && rm leftImg8bit_trainvaltest.zip
unzip gtFine_trainvaltest.zip && rm gtFine_trainvaltest.zip
```

The final file structure will be:
```
    .
    ├── ...                 
    ├── cityscapes
    │   ├── gtFine_trainvaltest
    │   │   ├── gtFine
    │   ├── leftImg8bit_trainvaltest 
    │   │   ├── leftImg8bit
    └── ...
```  

You should change the path in the "config.py" according to your Cityscapes dataset path. 
```bash
# Cityscapes Dir Location
_C.DATASET.CITYSCAPES_DIR = <YOUR_CITYSCAPES_PATH>
```

## Download Pretrained model
Use the following command to download the pretrained model "resnet101-imagenet.pth" and put it in the "pretrained" folder
```bash
pip install gdown
gdown https://drive.google.com/uc?id=1jMx3HdVqSlpIYIyG3VPi8q-ZiclOHlc7
```

## Train:
You can run the following commands to train our two variants of model from scratch. You can change the CUDA_VISIBLE_DEVICES according to your devices.
```bash
# train ASPP + HANet + Deeplabv3+
CUDA_VISIBLE_DEVICES=0,1,2,3 ./scripts/train_aspp.sh

# train WASP + HANet + Deeplabv3+
CUDA_VISIBLE_DEVICES=0,1,2,3 ./scripts/train_wasp.sh
```


## Evaluation

```bash
# evaluate with baseline Deeplabv3+
CUDA_VISIBLE_DEVICES=0,1,2,3 ./scripts/eval_baseline.sh ./pretrained/baseline_0.77801.pth ./results/baseline

# evaluate with ASPP + HANet + Deeplabv3+
CUDA_VISIBLE_DEVICES=0,1,2,3 ./scripts/eval_aspp.sh ./pretrained/aspp_0.78932.pth ./results/aspp

# evaluate with WASP + HANet + Deeplabv3+
CUDA_VISIBLE_DEVICES=0,1,2,3 ./scripts/eval_wasp.sh ./pretrained/wasp_0.79279.pth ./resultss/wasp

```
