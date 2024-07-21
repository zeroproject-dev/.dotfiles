#!/bin/bash

DEFAULT_DIR=${1-"$HOME/Pictures/Screenshots"}
NAME=$(date '+screenshot-%Y-%m-%d_%T.png')
TMP="/tmp/$NAME"

mkdir -p "$DEFAULT_DIR"

sleep 0.2
if ! scrot "$NAME" -s -f --line mode=classic 2>&1; then
  exit 1
fi

mv "$HOME/$NAME" "$TMP"

xclip -selection clipboard -target image/png -i "$TMP"

ACTION=$(dunstify --action="save,Save" --action="discard,Discard" -a "Screenshot" -u low -t 3000 -h string:x-dunst-stack-tag:screenshot "$NAME")

#TODO: Refactor for put new name with extension
case "$ACTION" in
"save")
  new_path=$(echo -e "\nNot select an option and enter new path\nDefault path:\n\t$DEFAULT_DIR/$NAME" | rofi -dmenu)
  if [ "$new_path" != "" ]; then
    if [ "${new_path:0:1}" == "/" ]; then
      mv "$TMP" "$(realpath -m "$new_path/$NAME")"
    else
      mv "$TMP" "$(realpath -m "$DEFAULT_DIR/$new_path/$NAME")"
    fi
  else
    mv "$TMP" "$DEFAULT_DIR/$NAME"
  fi
  ;;
"discard")
  rm -rf "$TMP"
  ;;
"2")
  rm -rf "$TMP"
  ;;
"1")
  rm -rf "$TMP"
  ;;
esac
