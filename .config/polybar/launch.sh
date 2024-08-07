#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar primary -r 2>&1 | tee -a /tmp/polybar.log &
disown
polybar leftbar -r 2>&1 | tee -a /tmp/polybar.log &
disown
polybar ipbar -r 2>&1 | tee -a /tmp/polybar.log &
disown
polybar rightbar -r 2>&1 | tee -a /tmp/polybar.log &
disown
polybar traybar -r 2>&1 | tee -a /tmp/polybar.log &
disown
polybar namebar -r 2>&1 | tee -a /tmp/polybar.log &
disown

echo "Polybar launched..."
