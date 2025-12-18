#! /bin/bash
set -e # stops execution if any error occurs

STEP=""

usage() {
  echo "Usage: $0 [-s step]"
  exit 1
}

while getopts "s:" opt; do
  case "$opt" in
  s) STEP="$OPTARG" ;;
  *) usage ;;
  esac
done

case "$STEP" in
hypr | initial)
  echo "Skipping step: '$STEP'..."
  ;;
*)
  echo "Invalid mode: '$STEP'"
  exit 1
  ;;
esac

mkdir -p "$HOME/packages"
cd "$HOME/packages"

sudo pacman -S --needed --noconfirm \
  git \
  base-devel \
  go # YAY dependency

if [[ ! -d yay ]]; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si

  command -v yay >/dev/null || {
    echo "yay installation failed"
    exit 1
  }
fi

if [[ "$STEP" != "hypr" ]]; then
  yay -S hyprland-git
fi

if [[ "$STEP" != "initial" ]]; then
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
  cp -r "$HOME/packages/dotfiles/configs/." "$HOME/.config"

  # Copies ZSH dotfiles
  cp -r "$HOME/packages/dotfiles/configs/zsh/." "$HOME/"

  # makes zsh default shell
  chsh -s /usr/bin/zsh

  # Enables PipeWire and WirePlumber services
  systemctl --user enable --now pipewire wireplumber

  # uses alsa-utils to unmute master sound
  unmute_audio() {
    for i in {1..20}; do
      if amixer scontrols | grep -q 'Master'; then
        amixer sset Master unmute
        return 0
      fi
      sleep 0.25
    done
    return 1
  }

  if unmute_audio; then
    echo "Master audio control was unmuted"
  else
    echo "Error while unmuting Master control"
  fi

  cd "$HOME/packages"
  if [[ ! -d snapd ]]; then
    git clone https://aur.archlinux.org/snapd.git
  fi

  cd snapd
  makepkg -si

  sudo systemctl enable --now snapd.socket           # enables snap service
  sudo systemctl enable --now snapd.apparmor.service # enabled app armor
  sudo ln -s /var/lib/snapd/snap /snap               # enable snap classic support

  # wait until snap finished seeding
  sudo snap wait system seed.loaded

  # user apps installation
  sudo pacman -S --needed --noconfirm \
    firefox \
    neovim

  sudo snap install obsidian --classic

  # CONFIGURES NeoVIM
  cd "$HOME/.config"
  if [[ ! -d nvim ]]; then
    git clone https://github.com/us0p/nvim.git
    cd nvim
    chmod +x ./setup.sh
    ./setup.sh
  fi

  # Must be last to be enabled
  sudo systemctl enable --now sddm.service

  exec "$SHELL"
fi
