#! /bin/bash

cat ~/.local/share/nerd-icons.txt |
  jq -r 'to_entries[] | "\(.value.char)  \(.key)"' |
  fzf --prompt="Icon ❯ " |
  awk '{print $1}' |
  tr -d '\n' |
  wl-copy
