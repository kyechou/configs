#!/bin/bash

NVFILE="/etc/X11/xorg.conf.d/20-nvidia.conf"
BACKUP="$NVFILE.back"

# Nvidia
# https://wiki.hyprland.org/Configuring/Environment-variables/#nvidia-specific
dGPU_status=$(for p in /sys/class/drm/*/status; do
    con=${p%/status}
    echo -n "${con#*/card?-}:"
    cat "$p"
done | grep '\<DP-' | cut -d: -f2 | grep -v disconnected | head -n1)

if [[ "$dGPU_status" = connected ]]; then
    if [[ ! -f "$NVFILE" ]]; then
        sudo mv "$BACKUP" "$NVFILE"
    fi
else
    if [[ -f "$NVFILE" ]]; then
        sudo mv "$NVFILE" "$BACKUP"
    fi
fi

exec startx > "$HOME/.local/share/xorg/client.log" 2>&1

