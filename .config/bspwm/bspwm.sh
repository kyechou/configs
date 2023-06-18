#!/bin/bash

NVFILE="/etc/X11/xorg.conf.d/20-nvidia.conf"
BACKUP="$NVFILE.back"

# Nvidia
# https://wiki.hyprland.org/Configuring/Environment-variables/#nvidia-specific
dGPU_status=(
    $(for p in /sys/class/drm/*/status; do
        con=${p%/status}
        echo -n "${con#*/card?-}:"
        cat "$p"
    done | grep -E '\<DP-|HDMI-' | cut -d: -f2)
)

dGPU_connected=0
for s in "${dGPU_status[@]}"; do
    if [[ "$s" = connected ]]; then
        dGPU_connected=1
    fi
done

if [[ $dGPU_connected -ne 0 ]]; then
    if [[ -f "$BACKUP" ]] && [[ ! -f "$NVFILE" ]]; then
        sudo mv "$BACKUP" "$NVFILE"
    fi
else
    if [[ -f "$NVFILE" ]] && [[ ! -f "$BACKUP" ]]; then
        sudo mv "$NVFILE" "$BACKUP"
    fi
fi

exec startx > "$HOME/.local/share/xorg/client.log" 2>&1

