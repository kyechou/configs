#!/bin/bash

# Wayland, Hyprland
export _JAVA_AWT_WM_NONREPARENTING=1
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland
export XDG_CURRENT_DESKTOP=Hyprland
export GDK_BACKEND='wayland,x11'
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM='wayland;xcb'
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export LIBSEAT_BACKEND=logind

# Nvidia
# https://wiki.hyprland.org/Configuring/Environment-variables/#nvidia-specific
mapfile -t dGPU_status < <(
    for p in /sys/class/drm/*/status; do
        con=${p%/status}
        echo -n "${con#*/card?-}:"
        cat "$p"
    done | grep -E '\<DP-|\<HDMI-' | cut -d: -f2
)

dGPU_connected=0
for s in "${dGPU_status[@]}"; do
    if [[ "$s" = connected ]]; then
        dGPU_connected=1
    fi
done

if [[ $dGPU_connected -ne 0 ]]; then
    export LIBVA_DRIVER_NAME=nvidia
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __GLX_GSYNC_ALLOWED=1
    export __GL_VRR_ALLOWED=1
    export __GL_GSYNC_ALLOWED=1
    export WLR_NO_HARDWARE_CURSORS=1
    export WLR_DRM_DEVICES=/dev/dri/card0
fi

# GTK themes
export GTK_THEME=Kanagawa-Borderless:dark
export GTK_ICON_THEME=Everforest-Dark
export XCURSOR_THEME=phinger-cursors
export XCURSOR_SIZE=32

exec Hyprland
