#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
cd "$SCRIPT_DIR"

msg() {
    echo -e "[+] ${1-}" >&2
}

die() {
    echo -e "[!] ${1-}" >&2
    exit 1
}

[ $UID -eq 0 ] && die 'Please run this script without root privilege'

NVFILE="/etc/X11/xorg.conf.d/20-nvidia.conf"
BACKUP="$NVFILE.back"
SWITCH=1

usage() {
    cat <<EOF
[!] Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-s]
    Options:
        -h, --help      Show this message and exit
        -s, --status    Show the current config status
EOF
}

# parse parameters
while :; do
    case "${1-}" in
    -h | --help) usage; exit ;;
    -s | --status) SWITCH=0 ;;
    -?*) die "Unknown option: $1\n$(usage)" ;;
    *) break ;;
    esac
    shift
done

# switch default GPU
if [ $SWITCH -ne 0 ]; then
    msg 'Toggling GPU setting...'
    if [ -f "$NVFILE" ]; then
        sudo mv "$NVFILE" "$BACKUP"
    elif [ -f "$BACKUP" ]; then
        sudo mv "$BACKUP" "$NVFILE"
    fi
fi

# show status
if [ -f "$NVFILE" ]; then
    msg 'Status: Nvidia dGPU'
else
    msg 'Status: Intel iGPU'
fi

# vim: set ts=4 sw=4 et:
