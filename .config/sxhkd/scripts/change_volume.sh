#!/bin/bash
msgTag="Volume"

function send_notification {
	volume="$(pamixer --get-volume)"
	mute="$(pamixer --get-mute)"

	if [[ $volume == 0 || "$mute" == "true" ]]; then
		dunstify -a "changeVolume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Volume muted" &
	else
		dunstify -a "changeVolume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$msgTag \
			-h int:value:"$volume" "Volume: ${volume}%" &
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
