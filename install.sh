#! /bin/bash

sudo pacman -S --needed --noconfirm \
  git \
  base-devel \
  go # YAY dependency

mkdir "$HOME/packages"
cd "$HOME/packages"

git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si
