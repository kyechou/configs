#!/bin/bash

width="$(swaymsg -r -t get_outputs | jq '.[] | select(.focused == true).current_mode.width')"
height="$(swaymsg -r -t get_outputs | jq '.[] | select(.focused == true).current_mode.height')"
ydotool mousemove --absolute -- $((width / 2)) $((height / 2))
