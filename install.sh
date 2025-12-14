#! /bin/bash
set -e # stops execution if any error occurs

sudo pacman -S --needed --noconfirm \
  git \
  base-devel \
  go # YAY dependency

mkdir -p "$HOME/packages" # -p ?
cd "$HOME/packages"

if [[ ! -d yay ]]; then
  git clone https://aur.archlinux.org/yay.git
fi

cd yay
makepkg -si

command -v yay >/dev/null || {
  echo "yay installation failed"
  exit 1
}

yay -S hyprland-git
