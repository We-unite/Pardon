#!/bin/bash
diff_output=$(diff "$1" "$2")

if [ -z "$diff_output" ];then
    echo "The two files are totally the same!"
else
    echo "There's something different: "
    echo "$diff_output"
fi
exit 0
