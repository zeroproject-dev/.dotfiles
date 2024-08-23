#!/bin/sh

setxkbmap -layout us -variant altgr-intl
feh --bg-fill "${HOME}/.dotfiles/wallpapers/wallpaper26.jpg" &

pkill picom
picom &

pkill dunst
dusnt &

pkill nm-applet
nm-applet &

pkill udiskie
udiskie -t &

xsetroot -cursor_name left_ptr &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

xset -dpms &
xset s off &
