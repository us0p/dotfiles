## Install
- hyprland
- wofi
- SDDM (must be enabled)
- ghostty
- pipewire
- wireplumber
- pipewire-alsa
- pipewire-audio
- alsa-utils
    - unmute sound
- dunst
    - must install libnotify as a dependency
- waybar
- snapd from archlinux aur (enables snap installs)
- zsh
    - set it as default shell
    - copy config from .bashrc to .zshrc and from .bash_profile to .zprofile

## User APPS
- FireFox (pacman)
- NeoVIM (pacman)
- Obsidian (snap install)

## Must Learn
- Linux
- Bash Scripting

## Config Files Changed
- ~/.config/hypr/hyprland.conf

## Installation script
Download installation script and execute it:
```bash
curl -fsSL https://raw.githubusercontent.com/us0p/dotfiles/refs/heads/main/install.sh -o install.sh
chmod +x install.sh
./install.sh
```

## NEXT STEPS
- How to effective reproduce config files in a user extensible way?
- Setup a reproducible environment that can execute Hyprland to test dotfiles scripts.
- Divide install script into sections to make it atomic and reduce testing time.
