#!/bin/bash

# 检查参数数量
if [ $# -ne 1 ]; then
  echo "请提供一个Java文件名作为参数"
  exit 1
fi

filename=$1
classname="${filename%.*}"
javac "$filename"
if [ $? -eq 0 ]; then
    java "$classname"
    rm "$classname.class"
else
    echo "Java文件编译失败！"
fi
