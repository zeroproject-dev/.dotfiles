#!/bin/bash
msgTag="Volume"

function send_notification {
	volume="$(pamixer --get-volume)"
	mute="$(pamixer --get-mute)"

	dunstParameters="-a \"changeVolume\" -u low -t 1500 -h string:x-dunst-stack-tag:$msgTag"

	if [[ $volume == 0 || "$mute" == "true" ]]; then
		dunstify $dunstParameters "󰝟 Volume muted" &
	else
		dunstify $dunstParameters -h int:value:"$volume" "󰕾 Volume: ${volume}%" &
	fi
}

case $1 in
up)
	pactl set-sink-volume @DEFAULT_SINK@ +2%
	;;
down)
	pactl set-sink-volume @DEFAULT_SINK@ -2%
	;;
mute)
	pactl set-sink-mute @DEFAULT_SINK@ toggle
	;;
esac

send_notification
