#!/bin/bash

##########################################################################
# File Name    : compile.sh
# Encoding     : utf-8
# Author       : We-unite
# Email        : weunite1848@gmail.com
# Created Time : 2024-02-29 15:19:15
##########################################################################

set -e

if [ $UID -eq 0 ]; then
	echo "Please do not run this script as root"
	exit 1
fi

if [ $# -ne 2 ]; then
	echo "Usage: $0 <static|shared> <v7|v8>"
	exit 1
fi

if [ $2 == "v8" ]; then
	arch=arm64-v8a
elif [ $2 == "v7" ]; then
	arch=armeabi-v7a
else
	echo "Usage: $0 <static|shared> <v7|v8>"
	exit 1
fi

link=$1 # static or shared
native_path=~/app/native

export PATH=$native_path/build-tools/cmake/bin:$PATH
# 清空CPATH，防止影响编译
export CPATH=

# 使用cmake编译，编译生成的文件运行在rk3568上
cmake -B build -D OHOS_STL=c++_$link -D OHOS_ARCH=$arch -D OHOS_PLATFORM=OHOS -D CMAKE_TOOLCHAIN_FILE=$(find $native_path -name ohos.toolchain.cmake)
cmake --build build
