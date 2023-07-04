#!/bin/bash

animation_enabled=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')

if [[ "$animation_enabled" == 1 ]]; then
    hyprctl --batch "\
        keyword general:border_size 1;\
        keyword decoration:rounding 0;\
        keyword decoration:active_opacity 1.0;\
        keyword decoration:inactive_opacity 1.0;\
        keyword decoration:fullscreen_opacity 1.0;\
        keyword decoration:blur 0;\
        keyword decoration:drop_shadow 0;\
        keyword animations:enabled 0;\
    " >/dev/null
else
    hyprctl reload >/dev/null
fi
