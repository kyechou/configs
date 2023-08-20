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

laptop_lid_status() {
    awk -F ' ' '{print $2}' </proc/acpi/button/lid/LID0/state
}

main() {
    parse_params "$@"

    laptop_monitor="eDP-1"
    laptop_scale=1.25
    lid_status="$(laptop_lid_status)"
    cmds=''

    if [[ "$lid_status" == "open" ]]; then
        cmds+="keyword monitor $laptop_monitor,preferred,auto,$laptop_scale;"
    elif [[ "$lid_status" == "closed" ]]; then
        cmds+="keyword monitor $laptop_monitor,disable"
    else
        die "Unknown lid status: '$lid_status'. Expected 'open' or 'closed'"
    fi

    # All other monitors are enabled by default.
    cmds+='keyword monitor ,preferred,auto,1;'

    # Run the commands.
    hyprctl --batch "$cmds" >/dev/null
}

main "$@"

# vim: set ts=4 sw=4 et:
