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

# installing system components
sudo pacman -S --needed --noconfirm \
  wofi \
  sddm \
  ghostty \
  pipewire \
  wireplumber \
  pipewire-alsa \
  pipewire-audio \
  alsa-utils \
  dunst \
  libnotify \
  waybar \
  zsh # Must make default shell, copy config from repo

cd "$HOME/packages"

if [[ ! -d dotfiles ]]; then
  git clone https://github.com/us0p/dotfiles.git
fi

# Copies Hyprland initial config to fresh install
cp "$HOME/packages/dotfiles/configs/hyprland/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
cp -r "$HOME/packages/dotfiles/configs/." "$HOME/"

# makes zsh default shell
chsh -s /usr/bin/zsh

# uses alsa-utils to unmute master sound
amixer sset Master unmute

cd "$HOME/packages"
if [[ ! -d snapd ]]; then
  git clone https://aur.archlinux.org/snapd.git
fi

cd snapd
makepkg -si

sudo systemctl enable --now snapd.socket           # enables snap service
sudo systemctl enable --now snapd.apparmor.service # enabled app armor
sudo ln -s /var/lib/snapd/snap /snap               # enable snap classic support

# user apps installation
sudo pacman -S --needed --noconfirm \
  firefox \
  neovim

sudo snap install obsidian --classic

# CONFIGURES NeoVIM

# Must be last to be enabled
sudo systemctl enable --now sddm.service
