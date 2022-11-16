#!/bin/bash

autostart() {
    prog=$1
    if pgrep "$prog"; then return; fi
    "$@" &
}

autorestart() {
    prog=$1
    if pgrep "$prog"; then pkill "$prog"; fi
    "$@" &
}

main() {
    #
    # systemctl user environment
    #
    #systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
    systemctl --user start wireplumber

    #
    # desktop environment applets
    #
    autostart waybar
    ~/.config/wallpaper.sh
    autostart dunst
    autostart lxpolkit # needed by virt-manager
    autostart /usr/lib/geoclue-2.0/demos/agent # needed by redshift/gammastep
    autostart light -S 70
    autostart fcitx5 -d --replace
    autostart nm-applet --indicator
    #autostart gammastep
    # https://www.reddit.com/r/gnome/comments/tzxeax/is_there_currently_a_solution_to_screen_color/

    #
    # User space applications
    #
    until ping -c1 www.google.com >/dev/null 2>&1; do sleep 1; done
    #autostart thunderbird
    #autostart ferdi
}


main "$@"
