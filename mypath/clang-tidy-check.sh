#!/bin/bash

##########################################################################
# File Name    : clang-tidy-check.sh
# Encoding     : utf-8
# Author       : We-unite
# Email        : weunite1848@gmail.com
# Created Time : 2024-04-28 16:50:37
##########################################################################

set -e

clang-tidy -checks="-*,$2" -header-filter=.* $1 -- -I/usr/include
