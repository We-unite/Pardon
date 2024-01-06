#!/bin/bash

# 检查参数数量,小于一报错
# if [ $# -e 0 ]; then
#   echo "请提供一个文件名作为参数"
#   exit 1
# fi

filename=$1
extension="${filename##*.}"  # 获取文件名的扩展名部分

# 检查文件后缀并执行相应的编译命令
if [ "$extension" = "c" ]; then
  gcc -g -o "${filename%.*}" -g "$filename" $2
elif [ "$extension" = "cpp" ]; then
  g++ -g -o "${filename%.*}" -g "$filename" $2
else
  echo "不支持的文件类型"
  exit 1
fi

exit 0
