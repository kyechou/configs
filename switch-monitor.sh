#!/bin/bash

set -e
set -o nounset

SCRIPT_DIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
cd "$SCRIPT_DIR"

[ $UID -eq 0 ] && \
    (echo '[!] Please run this script without root privilege' >&2; exit 1)

NVFILE="/etc/X11/xorg.conf.d/20-nvidia.conf"
BACKUP="$NVFILE.back"

usage()
{
    echo "[!] Usage: $0 [OPTIONS]" >&2
    echo '    Options:' >&2
    echo '        -h    show this message and exit' >&2
    echo '        -s    show the current config status' >&2
}

while getopts 'sh' op; do
    case $op in
        s)
            if [[ -f "$NVFILE" ]]; then
                echo 'Status: Nvidia driving external monitor'
            else
                echo 'Status: Intel driving laptop monitor'
            fi
            exit 0 ;;
        h)
            usage
            exit 0 ;;
        *)
            usage
            exit 1 ;;
    esac
done

if [[ -f "$NVFILE" ]]; then
    sudo mv "$NVFILE" "$BACKUP"
elif [[ -f "$BACKUP" ]]; then
    sudo mv "$BACKUP" "$NVFILE"
fi

# vim: set ts=4 sw=4 et:
