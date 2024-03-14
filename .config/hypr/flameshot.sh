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
    -s, --screen        Take a screenshot of the entire monitor
EOF
}

parse_params() {
    SCREEN=0
    while :; do
        case "${1-}" in
        -h | --help)
            usage
            exit
            ;;
        -v | --verbose) set -x ;;
        -s | --screen) SCREEN=1 ;;
        -?*) die "Unknown option: $1\n$(usage)" ;;
        *) break ;;
        esac
        shift
    done
}

main() {
    parse_params "$@"

    local scale
    scale="$(hyprctl monitors | grep -B 2 'focused:.*yes' | grep scale | cut -d: -f2 | sed 's/ //g')"
    local inv_scale
    inv_scale="$(echo "$scale" | awk '{ printf("%f\n", 1/$1) }')"

    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_SCREEN_SCALE_FACTORS="$inv_scale"

    if [[ $SCREEN -eq 1 ]]; then
        flameshot screen
    else
        flameshot gui
    fi
}

main "$@"

# vim: set ts=4 sw=4 et:
