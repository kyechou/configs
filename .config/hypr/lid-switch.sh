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
    -o, --open          Lid open
    -c, --close         Lid close
EOF
}

parse_params() {
    OP=

    while :; do
        case "${1-}" in
        -h | --help)
            usage
            exit
            ;;
        -v | --verbose) set -x ;;
        -o | --open) OP=open ;;
        -c | --close) OP=close ;;
        -?*) die "Unknown option: $1\n$(usage)" ;;
        *) break ;;
        esac
        shift
    done

    export OP
}

main() {
    parse_params "$@"

    laptop_monitor="eDP-1"
    num_monitors=$(hyprctl monitors | grep -c ^Monitor)

    if [[ "$OP" == "open" ]]; then
        hyprctl keyword monitor "$laptop_monitor,preferred,auto,1.2"
    elif [[ "$OP" == "close" ]]; then
        if [[ $num_monitors -le 1 ]]; then
            swaylock
            systemctl suspend
        else
            hyprctl keyword monitor "$laptop_monitor,disable"
        fi
    fi
}

main "$@"

# vim: set ts=4 sw=4 et:
