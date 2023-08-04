#!/bin/bash

selected_option=$(echo -e "Shutdown\nLogout\nReboot" | rofi -dmenu -i -p "Select an option: ")

case "$selected_option" in
"Shutdown")
	systemctl poweroff
	;;
"Logout")
	kill -9 -1
	;;
"Reboot")
	systemctl reboot
	;;
esac
