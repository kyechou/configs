#!/bin/bash

set -euo pipefail

wallpaper="/tmp/wallpaper.png"
width="$(xrandr | head -n1 | cut -d ' ' -f 8 | tr -d ,)"
display_height="$(xrandr | head -n1 | cut -d ' ' -f 10 | tr -d ,)"
#bar_height="$(grep ^height $HOME/.config/polybar/config.ini | cut -d ' ' -f 3)"
#height="$((display_height - bar_height))"
height=$display_height

source "$HOME/.config/colorscheme.sh"
fg_color=${fujiWhite:1}
bg_color=${sumiInk1:1}
pid_font_color=${fujiGray:1}
bar_fg=${springViolet1:1}
bar_bg=${sumiInk3:1}
dot_color=(${crystalBlue:1}77 ${autumnRed:1}99)
link_color=(${waveBlue1:1} ${autumnRed:1}cc)

pscircle \
    --background-color=$bg_color \
    --collapse-threads=1 \
    --dot-radius=4 \
    --dot-border-width=2 \
    --dot-border-color-max=${dot_color[1]} \
    --dot-border-color-min=${dot_color[0]} \
    --dot-color-max=${dot_color[1]} \
    --dot-color-min=${dot_color[0]} \
    --link-color-max=${link_color[1]} \
    --link-color-min=${link_color[0]} \
    --link-convexity=0.5 \
    --link-width=2.5 \
    --toplists-bar-background=$bar_bg \
    --toplists-bar-color=$bar_fg \
    --toplists-bar-height=7 \
    --toplists-bar-width=70 \
    --toplists-column-padding=12 \
    --toplists-font-color=$fg_color \
    --toplists-font-face="Iosevka Etoile" \
    --toplists-font-size=18 \
    --toplists-pid-font-color=$pid_font_color \
    --toplists-row-height=30 \
    --tree-font-color=$fg_color \
    --tree-font-face="Iosevka" \
    --tree-font-size=16 \
    --tree-radius-increment=200 \
    --output-height=$height \
    --output-width=$width \
    --output="$wallpaper"
feh --bg-fill "$wallpaper"
