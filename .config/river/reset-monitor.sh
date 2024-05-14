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

    Reset river monitors

    Options:
    -h, --help          Print this help and exit
    -v, --verbose       Print script debug info
    -l, --lid           Handle laptop lid switch events
EOF
}

parse_params() {
    LID_SWITCH=0
    while :; do
        case "${1-}" in
        -h | --help)
            usage
            exit
            ;;
        -v | --verbose) set -x ;;
        -l | --lid) LID_SWITCH=1 ;;
        -?*) die "Unknown option: $1\n$(usage)" ;;
        *) break ;;
        esac
        shift
    done
}

laptop_lid_status() {
    awk -F ' ' '{print $2}' </proc/acpi/button/lid/LID0/state
}

get_external_monitors() {
    wlr-randr --json | jq -r .[].name | grep -v "^${laptop_monitor}$"
}

lid_switch() {
    # Handle laptop lid switch events
    if [[ "$lid_status" == "open" ]]; then
        wlr-randr --output "$laptop_monitor" --on --scale "$laptop_scale"
    elif [[ "$lid_status" == "closed" ]]; then
        if [[ ${#ext_mons[@]} -eq 0 ]]; then
            swaylock
            systemctl suspend
        else
            wlr-randr --output "$laptop_monitor" --off
        fi
    else
        die "Unknown lid status: '$lid_status'. Expected 'open' or 'closed'"
    fi
}

reset_monitor() {
    if [[ "$lid_status" == "open" ]]; then
        # Turn on the laptop monitor.
        wlr-randr --output "$laptop_monitor" --on --scale "$laptop_scale"
        # Turn on the external monitors.
        for mon in "${ext_mons[@]}"; do
            wlr-randr --output "$mon" --on --scale "$ext_scale"
        done
    elif [[ "$lid_status" == "closed" ]]; then
        # Turn off the laptop monitor.
        wlr-randr --output "$laptop_monitor" --off
        if [[ ${#ext_mons[@]} -eq 1 ]]; then
            # Turn on the external monitor and move it to <0,0> if it's the only
            # monitor.
            wlr-randr --output "${ext_mons[0]}" --on --pos 0,0 --scale "$ext_scale"
        else
            # Otherwise, turn on all external monitors.
            for mon in "${ext_mons[@]}"; do
                wlr-randr --output "$mon" --on --scale "$ext_scale"
            done
        fi
    else
        die "Unknown lid status: '$lid_status'. Expected 'open' or 'closed'"
    fi
}

main() {
    parse_params "$@"

    laptop_monitor="eDP-1"
    laptop_scale=1.5
    ext_scale=1.1
    lid_status="$(laptop_lid_status)"
    set +e
    mapfile -t ext_mons < <(get_external_monitors)
    set -e

    if [[ $LID_SWITCH -eq 1 ]]; then
        lid_switch
    else
        reset_monitor
    fi
}

main "$@"

# vim: set ts=4 sw=4 et:
