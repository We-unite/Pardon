#!/bin/bash

##########################################################################
# File Name    : search.sh
# Encoding     : utf-8
# Author       : We-unite
# Email        : weunite1848@gmail.com
# Created Time : 2024-03-26 01:15:43
##########################################################################

set -e

# 在当前文件夹下查找含有指定内容的文件，并输出其文件名、行号和上下文
# 每个文件先输出文件名，然后输出包含指定内容的行号和上下文
# 用法：./search.sh <search_content> <context_lines>
# 允许按顺序缺省参数

# 检查参数个数
if [ $# -lt 1 ]; then
	echo "Usage: $0 <search_content> <path> <file_type>"
	exit 1
fi

# 检查参数是否为空
if [ -z "$1" ]; then
	echo "Error: search_content is empty"
	exit 1
fi

if [ -z "$2" ]; then
	context_lines=3
else
	if [ -z "$(echo $2 | grep -E '^[0-9]+$')" ]; then
		echo "Error: context_lines $2 is invalid"
		exit 1
	fi
	context_lines=$2
fi

# 查找文件
find . -type f | while read file; do
	# 查找文件中包含指定内容的行，存储到变量中
	lines=$(grep -C "$context_lines" -n "$1" $file | sed 's/:/ /')
	if [ "$lines" == "" ]; then
		continue
	else
		# 彩色输出文件名
		echo -e "\033[1;32m$file\033[0m"
		# 输出包含指定内容的行号和上下文
		echo -e "$lines"
	fi
done
