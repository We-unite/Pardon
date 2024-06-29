#!/bin/bash

##########################################################################
# File Name    : gitadd.sh
# Encoding     : utf-8
# Author       : We-unite
# Email        : weunite1848@gmail.com
# Created Time : 2024-03-21 19:26:53
##########################################################################

set -e

repo_name=""
# 判断参数个数
if [ $# -ne 1 ]; then
	echo "Input repository name: "
	read name
	repo_name=$name
else
	repo_name=$1
fi

sudo -u git -H bash -c "cd ~ && git init --bare $repo_name.git"
echo "Input description for the repository:"
read desc
sudo -u git -H bash -c "echo $desc > ~/$repo_name.git/description"
echo "Repository $1.git created successfully!"
