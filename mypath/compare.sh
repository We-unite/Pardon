#!/bin/bash

file1="file1.txt"
file2="file2.txt"

diff_output=$(diff "$file1" "$file2")

if [ -z "$diff_output" ]; then
  echo "两个文件完全一致"
else
  echo "两个文件不完全一致"
  echo "$diff_output"
fi

