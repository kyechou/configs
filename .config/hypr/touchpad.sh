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

    Enable/Disable the touchpad

    Options:
    -h, --help          Print this help and exit
    -v, --verbose       Print script debug info
    -1, --enable        Enable the touchpad
    -0, --disable       Disable the touchpad
EOF
}

parse_params() {
    ENABLE=
    while :; do
        case "${1-}" in
        -h | --help)
            usage
            exit
            ;;
        -v | --verbose) set -x ;;
        -1 | --enable) ENABLE=true ;;
        -0 | --disable) ENABLE=false ;;
        -?*) die "Unknown option: $1\n$(usage)" ;;
        *) break ;;
        esac
        shift
    done
}

main() {
    parse_params "$@"

    if [[ -n "$ENABLE" ]]; then
        # shellcheck disable=SC2016
        hyprctl -r keyword '$touchpad_enable' $ENABLE
    fi
}

main "$@"

# vim: set ts=4 sw=4 et:
