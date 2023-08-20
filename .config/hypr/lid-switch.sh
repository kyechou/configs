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

    Handle laptop lid swith events

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
    laptop_scale=1.25 # This has to be consistent with reset-monitor.sh
    lid_status="$(laptop_lid_status)"
    num_monitors=$(hyprctl monitors | grep -c ^Monitor)

    if [[ "$lid_status" == "open" ]]; then
        hyprctl keyword monitor "$laptop_monitor,preferred,auto,$laptop_scale"
    elif [[ "$lid_status" == "closed" ]]; then
        if [[ $num_monitors -le 1 ]]; then
            swaylock
            systemctl suspend
        else
            hyprctl keyword monitor "$laptop_monitor,disable"
        fi
    else
        die "Unknown lid status: '$lid_status'. Expected 'open' or 'closed'"
    fi
}

main "$@"

# vim: set ts=4 sw=4 et:
