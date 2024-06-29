#!/bin/bash

##########################################################################
# File Name    : ast.sh
# Encoding     : utf-8
# Author       : We-unite
# Email        : weunite1848@gmail.com
# Created Time : 2024-06-02 15:00:21
##########################################################################

/home/player/app/llvm-project/build/bin/clang -cc1 -ast-dump $1
