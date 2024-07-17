#!/bin/bash

set -e

DEFAULT_DIR=${1-"$HOME/Pictures/Screenshots"}
NAME=$(date '+screenshot-%Y-%m-%d_%T.png')

echo "default dir: $DEFAULT_DIR"

mkdir -p "$DEFAULT_DIR"

scrot "$NAME" --delay=0 -s -f --line mode=classic -e "mv \$f /tmp/$NAME && xclip -selection clipboard -target image/png -i /tmp/$NAME"

ACTION=$(dunstify --action="save,Save" --action="discard,Discard" -a "Screenshot" -u low -t 3000 -h string:x-dunst-stack-tag:screenshot "$NAME")

#TODO: Refactor for put new name with extension
case "$ACTION" in
"save")
  new_path=$(echo -e "\nNot select an option and enter new path\nDefault path:\n\t$DEFAULT_DIR/$NAME" | rofi -dmenu)
  if [ "$new_path" != "" ]; then
    if [ "${new_path:0:1}" == "/" ]; then
      mv "/tmp/$NAME" "$(realpath -m "$new_path/$NAME")"
    else
      mv "/tmp/$NAME" "$(realpath -m "$DEFAULT_DIR/$new_path/$NAME")"
    fi
  else
    mv "/tmp/$NAME" "$DEFAULT_DIR/$NAME"
  fi
  ;;
"discard")
  rm -rf "/tmp/$NAME"
  ;;
"2")
  rm -rf "/tmp/$NAME"
  ;;
"1")
  rm -rf "/tmp/$NAME"
  ;;
esac
