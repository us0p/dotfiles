HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
