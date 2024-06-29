#!/bin/bash

##########################################################################
# File Name    : compile-tiny.sh
# Encoding     : utf-8
# Author       : We-unite
# Email        : weunite1848@gmail.com
# Created Time : 2024-04-16 13:06:58
##########################################################################

set -e
# 如果是root，报错
if [ $(id -u) -eq 0 ]; then
	echo "Do not run as root"
	exit 1
fi

if [ $# -ne 2 ]; then
	echo "Usage: $0 <src file> [armv8-a|armv7-a]"
	exit 1
fi

native=~/app/native
file=$1
targetFile=${file%.*}
arch=$2

case $arch in
	armv8-a)
		compiler=$native/llvm/bin/aarch64-unknown-linux-ohos
		targetPlatform=aarch64-linux-ohos
		;;
	armv7-a)
		compiler=$native/llvm/bin/armv7-unknown-linux-ohos
		targetPlatform=arm-linux-ohos
		;;
	*)
		echo "Unsupported arch"
		exit 1
		;;
esac

case ${file##*.} in
	c)
		compiler=$compiler-clang
		;;
	cpp)
		compiler=$compiler-clang++
		;;
	*)
		echo "Unsupported file type"
		exit 1
		;;
esac

export CPATH=

$compiler -o $targetFile $file -Wall \
	--target=$targetPlatform \
	--sysroot=$native/sysroot \
	-march=$arch -mfloat-abi=softfp
