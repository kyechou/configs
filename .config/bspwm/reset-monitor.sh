#!/bin/bash

set -euo pipefail

first_empty_desktop() {
    monitor=$1
    if ! bspc query -M $monitor >/dev/null; then
        return  # invalid monitor
    fi
    for desktop in $(bspc query -D -m $monitor); do
        if ! bspc query -N -d $desktop >/dev/null; then
            echo "$desktop"
            return
        fi
    done
}

switch_monitor() {
    DEST_MON=$1
    bspc monitor $DEST_MON -d 1 2 3 4 5 6 7 8 9 10
    for monitor in $(bspc query -M --names); do
        if [[ "$monitor" != "$DEST_MON" ]]; then
            for desktop in $(bspc query -D -m $monitor); do
                # swap non-empty desktops to the destination monitor
                if bspc query -N -d $desktop; then
                    DEST_DESK=$(first_empty_desktop "$DEST_MON")
                    bspc desktop $desktop -s $DEST_DESK
                fi
            done
            bspc monitor $monitor -r
        fi
    done
}

reset_monitor() {
    LAPTOP_MON="eDP-1"
    MONITORS="$(xrandr --listmonitors | sed '1d' | awk -F ' ' '{print $4}')"
    if [[ "${MONITORS[@]}" =~ "$LAPTOP_MON" ]]; then
        switch_monitor "$LAPTOP_MON"
        xrandr --newmode "1800x1200_60.00"  \
            180.75  1800 1920 2112 2424  1200 1203 1213 1245 -hsync +vsync
        xrandr --addmode "$LAPTOP_MON" "1800x1200_60.00"
        xrandr --output "$LAPTOP_MON" --mode "1800x1200_60.00"
    else
        switch_monitor "$(echo "${MONITORS[@]}" | head -n1)"
    fi
}

reset_monitor
~/.config/polybar/launch.sh
