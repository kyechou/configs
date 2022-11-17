#!/bin/bash

width="$(hyprctl monitors -j | jq .[0].width)"
height="$(hyprctl monitors -j | jq .[0].height)"
ydotool mousemove --absolute -- $((width / 2)) $((height / 2))
