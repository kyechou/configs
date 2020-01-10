#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Launch Polybar, using default config location ~/.config/polybar/config
if command -v xrandr >/dev/null 2>&1; then
    for m in $(xrandr --listmonitors | sed '1d' | awk -F ' ' '{print $4}'); do
        MONITOR="$m" polybar --reload top >/dev/null &
    done
fi

# trigger an update on each non-empty desktop for polybar display
if command -v bspc >/dev/null 2>&1; then
    sleep 1
    for desktop in $(bspc query -D); do
        if bspc query -N -d $desktop; then
            bspc config -d $desktop top_padding 0
        fi
    done
fi
