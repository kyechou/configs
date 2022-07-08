#!/bin/bash

set -euo pipefail

wallpaper="/tmp/wallpaper.png"
width="$(xrandr | head -n1 | cut -d ' ' -f 8 | tr -d ,)"
display_height="$(xrandr | head -n1 | cut -d ' ' -f 10 | tr -d ,)"
bar_height="$(grep ^height $HOME/.config/polybar/config.ini | cut -d ' ' -f 3)"
height="$((display_height - bar_height))"
dot_radius_percentage=0.0028
dot_border_width_percentage=0.00138
toplists_font_percentage=0.014
toplists_col_padding_percentage=0.008
toplists_row_height_percentage=0.0208
tree_font_percentage=0.010
dot_radius=$(echo "$dot_radius_percentage * $height" | bc)
dot_border_width=$(echo "$dot_border_width_percentage * $height" | bc)
toplists_font_size=$(echo "$toplists_font_percentage * $height" | bc)
toplists_col_padding=$(echo "$toplists_col_padding_percentage * $height" | bc)
toplists_row_height=$(echo "$toplists_row_height_percentage * $height" | bc)
tree_font_size=$(echo "$tree_font_percentage * $height" | bc)
cpulist_x_percentage=0.260 # 0.238
cpulist_y_percentage=-0.080 # 0
memlist_x_percentage=0.260 # 0.385
memlist_y_percentage=0.080 # 0
tree_radius_percentage=0.059
cpulist_x=$(echo "$cpulist_x_percentage * $width" | bc)
cpulist_y=$(echo "$cpulist_y_percentage * $height" | bc)
memlist_x=$(echo "$memlist_x_percentage * $width" | bc)
memlist_y=$(echo "$memlist_y_percentage * $height" | bc)
tree_radius_increment=$(echo "$tree_radius_percentage * $width" | bc)

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
    --cpulist-center="${cpulist_x}:${cpulist_y}" \
    --memlist-center="${memlist_x}:${memlist_y}" \
    --dot-radius=$dot_radius \
    --dot-border-width=$dot_border_width \
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
    --toplists-column-padding=$toplists_col_padding \
    --toplists-font-color=$fg_color \
    --toplists-font-face="Iosevka Etoile" \
    --toplists-font-size=$toplists_font_size \
    --toplists-pid-font-color=$pid_font_color \
    --toplists-row-height=$toplists_row_height \
    --tree-font-color=$fg_color \
    --tree-font-face="Iosevka" \
    --tree-font-size=$tree_font_size \
    --tree-radius-increment=$tree_radius_increment \
    --output-height=$height \
    --output-width=$width \
    --output="$wallpaper"
feh --bg-max "$wallpaper" --image-bg "#$bg_color"
