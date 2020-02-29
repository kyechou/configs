#!/bin/bash

set -e
set -o nounset

SCRIPT_DIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
cd "$SCRIPT_DIR"

[ $UID -eq 0 ] && \
    (echo '[!] Please run this game without root privilege' >&2; exit 1)

mkdir -p logs
touch logs/{stats,public,private,social,trade}

if ! tmux has-session -t batmud 2>/dev/null; then
    tmux new-session -d -s batmud -n batmud -x- -y- 'tt++ -t BatMUD rc.tin'
    tmux split-window -t batmud:batmud.0 -h -l  60 'watch -ctn 0.5 "cat map.out"'
    tmux split-window -t batmud:batmud.0 -bh -l 60 'tail -f logs/public'
    tmux split-window -t batmud:batmud.0 -bv -l 13 'watch -ctn 0.5 "cat logs/stats"'
    tmux split-window -t batmud:batmud.1 -v -l  10 'tail -f logs/private'
    tmux split-window -t batmud:batmud.1 -v -l  10 'tail -f logs/social'
    tmux split-window -t batmud:batmud.5 -v -l  15 'tail -f logs/trade'
    tmux select-pane -t batmud:batmud.4
fi
tmux attach-session -t batmud
