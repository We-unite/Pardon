#!/bin/bash

# 检查参数个数
if [ $# -ne 1 ]; then
    echo "参数个数错误！"
    exit 1
fi

if [ $1 == "run" ]; then
    for file in *.sh; do
        filename="${file%.*}"
        ln -s "$file" "$filename"
    done
    echo "软链接创建完成！"
elif [ $1 == "del" ];then
    for file in *.sh; do
        filename="${file%.*}"
        rm -f "$filename"
    done
    echo "软链接删除成功！"
else
    echo "参数错误！"
    exit 1
fi
