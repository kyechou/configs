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

# GTK themes
export GTK_THEME=Kanagawa-Borderless:dark
export GTK_ICON_THEME=Everforest-Dark
export XCURSOR_THEME=phinger-cursors

exec Hyprland >"$HOME/.local/share/hyprland.log" 2>&1
