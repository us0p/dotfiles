#! /bin/bash

JSON="$HOME/.local/share/nerd-icons.txt"

jq -r '
    to_entries[]
    | "\(.value.char)  \(.key)"
' "$JSON" |
  wofi \
    --dmenu \
    --prompt "Icons" \
    --matching fuzzy \
    --cache-file /dev/null \
    --style ~/projects/dotfiles/styles/wofi/icon_picker.css |
  awk '{print $1}' |
  tr -d '\n' |
  wl-copy
