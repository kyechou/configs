#!/bin/bash

set -euo pipefail

msg() {
    echo -e "[+] ${1-}" >&2
}

die() {
    echo -e "[!] ${1-}" >&2
    exit 1
}

[ $UID -eq 0 ] && die 'Please run this script without root privilege'

usage() {
    cat <<EOF
[!] Usage: $(basename "${BASH_SOURCE[0]}") [options]

    Reset Hyprland monitors

    Options:
    -h, --help          Print this help and exit
    -v, --verbose       Print script debug info
EOF
}

parse_params() {
    while :; do
        case "${1-}" in
        -h | --help)
            usage
            exit
            ;;
        -v | --verbose) set -x ;;
        -?*) die "Unknown option: $1\n$(usage)" ;;
        *) break ;;
        esac
        shift
    done
}

main() {
    parse_params "$@"

    laptop_monitor="eDP-1"
    laptop_scale=1.25
    laptop_is_on=$(hyprctl monitors | grep -c "^Monitor $laptop_monitor ")
    num_monitors=$(hyprctl monitors | grep -c ^Monitor)
    cmds=''

    # All other monitors are enabled by default.
    cmds+='keyword monitor ,preferred,auto,1;'

    if [[ $laptop_is_on -gt 0 ]]; then
        # The laptop monitor is on.
        cmds+="keyword monitor $laptop_monitor,preferred,auto,$laptop_scale;"
    else
        # The laptop monitor is off. Keep it disabled.
        cmds+="keyword monitor $laptop_monitor,disable"
    fi

    # Run the commands.
    hyprctl --batch "$cmds" >/dev/null
}

main "$@"

# vim: set ts=4 sw=4 et:
