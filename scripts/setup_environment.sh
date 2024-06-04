# setup root path variable
ROOT_PATH=/snpe-v1.52

# setup android environemnt
export ANDROID_NDK_ROOT=$ROOT_PATH/android-ndk-r19c
export PATH=${ANDROID_NDK_ROOT}:${PATH}

# setup ${SNPE_ROOT} and ${ONNX_HOME} environment
source $ROOT_PATH/snpe-1.52.0.2724/bin/envsetup.sh -o /usr/local/lib/python3.6/dist-packages/onnx
