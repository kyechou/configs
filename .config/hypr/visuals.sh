#!/bin/bash

animation_enabled=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')

if [[ "$animation_enabled" == 1 ]]; then
    hyprctl keyword animations:enabled 0 >/dev/null
else
    hyprctl keyword animations:enabled 1 >/dev/null
fi
