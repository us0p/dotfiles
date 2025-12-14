#! /bin/bash

sudo pacman -S --needed git base-devel

mkdir $HOME/packages

cd ~/packages

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
