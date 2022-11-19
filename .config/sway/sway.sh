#!/bin/bash

# Wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export GDK_BACKEND='wayland,x11'
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM='wayland;xcb'
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# Nvidia
# https://wiki.hyprland.org/Configuring/Environment-variables/#nvidia-specific
dGPU_status=$(for p in /sys/class/drm/*/status; do
	con=${p%/status}
	echo -n "${con#*/card?-}:"
	cat "$p"
done | grep '\<DP-1\>' | cut -d: -f2)

if [[ "$dGPU_status" = connected ]]; then
    export LIBVA_DRIVER_NAME=nvidia
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __GLX_GSYNC_ALLOWED=1
    export __GL_VRR_ALLOWED=1
    export __GL_GSYNC_ALLOWED=1
    export WLR_DRM_NO_ATOMIC=1
    export WLR_NO_HARDWARE_CURSORS=1
    export WLR_DRM_DEVICES=/dev/dri/card0
fi

# GTK themes
export GTK_THEME=Kanagawa-Borderless
export GTK_ICON_THEME=Everforest-Dark
export XCURSOR_THEME=phinger-cursors
export XCURSOR_SIZE=32

exec sway --unsupported-gpu "$@"
