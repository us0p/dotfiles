#! /bin/bash

sudo pacman -S --needed --noconfirm git base-devel

mkdir "$HOME/packages"
cd "$HOME/packages"

git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si
