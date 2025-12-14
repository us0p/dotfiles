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

## Dotfiles DEV
- To run Hyprland on virtual machines use virt-manager.
    - Virt manager must use system's python, if you use some python version management tool, you need to turn back python version to global. e.g. pyenv `pyenv global system`.
- Should download one of the available arhc vm images on the wiki.
- Recommended configs are:
    - RAM: 4096MB
    - CPU: 2

## NEXT STEPS
- How to effective reproduce config files in a user extensible way?
- Divide install script into sections to make it atomic and reduce testing time.
