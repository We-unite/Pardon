#!/bin/bash

count_lines() {
    local filename=$1
    local sum=0
    local buf

    while IFS= read -r buf; do
        ((sum++))
    done < "$filename"

    echo "$sum"
}

extensions=("c" "tex" "cpp" "py" "h")
sum=0

for extension in "${extensions[@]}"; do
    files=$(find . -type f -name "*.$extension")
    for file in $files; do
        tmp=$(count_lines "$file")
        ((sum+=tmp))
        echo "文件路径: $file"
        echo "行数: $tmp"
        echo
    done
done

echo "总行数: $sum"

