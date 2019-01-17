#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Launch Polybar, using default config location ~/.config/polybar/config
if command -v xrandr >/dev/null 2>&1; then
	for m in $(xrandr --query | grep connected | cut -d ' ' -f 1); do
		MONITOR="$m" polybar --reload top >/dev/null 2>&1 &
	done
fi
