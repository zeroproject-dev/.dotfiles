#!/bin/bash

dir="$HOME/.dotfiles/.config/rofi"
theme="power"

uptime="$(uptime -p | sed -e 's/up //g')"

shutdown='⏻'
reboot='󰑓'
lock='󰷛'
suspend=''
logout='󰍃'
yes=''
no=''

rofi_cmd() {
  rofi -dmenu \
    -p "Uptime: $uptime" \
    -mesg "Uptime: $uptime" \
    -theme "${dir}/${theme}.rasi"
}

confirm_cmd() {
  rofi -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme "${dir}/shared/confirm.rasi"
}

confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

run_rofi() {
  echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--shutdown' ]]; then
      systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
      systemctl reboot
    elif [[ $1 == '--suspend' ]]; then
      systemctl suspend
    elif [[ $1 == '--logout' ]]; then
      bspc quit
    fi
  else
    exit 0
  fi
}

chosen="$(run_rofi)"
case ${chosen} in
"$shutdown")
  run_cmd --shutdown
  ;;
"$reboot")
  run_cmd --reboot
  ;;
"$lock")
  i3lock-fancy-rapid 5 3
  ;;
"$suspend")
  run_cmd --suspend
  ;;
"$logout")
  run_cmd --logout
  ;;
esac
