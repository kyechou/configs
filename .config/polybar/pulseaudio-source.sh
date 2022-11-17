#!/bin/bash

get_output() {
    if [[ "$(pactl get-source-mute @DEFAULT_SOURCE@)" == *"no"* ]]; then
        echo " $(pactl get-source-volume @DEFAULT_SOURCE@ | grep -oE '[0-9]+%' | head -n1)"
    else
        echo " muted"
    fi
}

listen() {
    get_output

    pactl subscribe | while read -r event; do
        if echo "$event" | grep -q 'source'; then
            get_output
        fi
    done
}

listen
