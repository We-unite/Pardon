#!/bin/bash

set -e # exit when error
# environment variables here

VIMRUNTIME=/usr/share/vim/vim91
color_file=industry.vim

# write a function to install sth,the parameter of the func is the packages
function install() {
	sudo apt update
	sudo apt upgrade
	sudo apt remove vim*
	sudo apt install -y git libatk1.0-dev libcairo2-dev liblua5.1-0-dev \
		libncurses5-dev libperl-dev libx11-dev libxpm-dev \
		libxt-dev lua5.1 python3-dev ruby-dev
	}

# check current user is root or not, if is, warn the user
if [ $UID -eq 0 ]; then
	echo -e "\033[31mYou are root, I recommand to use a normal user to run this script.\033[0m"
	exit
fi

cd ~
# if this is the first time to compile vim
if [ $# -eq 1 ] && [ $1 == "first" ]; then
	install
	if ! [ -d app ]; then
		mkdir app
	fi
	cd app
	echo -e "\033[32mGetting vim source code...\033[0m"
	git clone https://github.com/vim/vim
	cd vim/src
else
	cd app/vim/src
	sudo make uninstall
	make distclean
	echo -e "\033[32mGetting vim source code...\033[0m"
	git pull
fi

# get the default python version
python_version=$(python3 -V 2>&1 | awk '{print $2}' | awk -F '.' '{print $1"."$2}')
if [ -z $python_version ]; then
	echo -e "\033[31mInstalling python3...\033[0m"
	sudo apt update && sudo apt upgrade
	sudo apt install python3
	python_version=$(python3 -V 2>&1 | awk '{print $2}' | awk -F '.' '{print $1"."$2}')
fi
# if gtk installed, remove it
if [ -d /usr/local/include/gtk-2.0 ]; then
	sudo apt remove libgtk2.0-dev
fi

echo -e "\033[32mPython version: $python_version\033[0m"

echo -e "\033[32mConfiguring compile environment...\033[0m"
./configure \
	--with-features=huge \
	--enable-multibyte \
	--enable-rubyinterp=dynamic \
	--with-ruby-command=/usr/bin/ruby \
	--enable-luainterp\
	--enable-python3interp=dynamic \
	--with-python3-command=$(which python$python_version) \
	--with-python3-config-dir=$(python$python_version-config --configdir) \
	--enable-perlinterp=dynamic \
	--enable-largefile \
	--enable-cscope \
	--with-compiledby="An Ordinary Communist weunite1848@gmail.com" \
	--enable-fail-if-missing \
	--disable-gui \
	--prefix=/usr

echo -e "\033[32mCompiling vim...\033[0m"
make

echo -e "\033[32mInstalling vim...\033[0m"
sudo make install

echo -e "\033[32;36mCompile done!\033[0m"
vim --version | head -n 3

# test if the terminal support 256 colors, if so, configure the color file
if [ $(tput colors) -ge 256 ]; then
	color_file=$VIMRUNTIME/colors/$color_file
	echo -e "\033[32mConfiguring $color_file as transparent...\033[0m"
	sudo sed -i '/if s:t_Co >= 256/,/hi Normal/{s/hi Normal/" hi/}' $color_file
	sudo sed -i '/if s:t_Co >= 256/,/hi EndOfBuffer/{s/hi EndOfBuffer/" hi/}' $color_file
fi

echo -e "\033[32;36mDone.\033[0m"
