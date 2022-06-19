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

usage() {
    cat <<EOF
[!] Usage: $(basename "${BASH_SOURCE[0]}") [options]
    Options:
    -h, --help      Print this help and exit
    -v, --verbose   Print script debug info
    -d, --deploy    Deploy as in a CLI environment
    -a, --all       Deploy everything (as an Arch desktop)
    -s, --sync      Sync everything (as an Arch desktop)
    -n, --dry-run   Dry run
EOF
}

DEPLOY=0
DEPLOY_ALL=0
SYNC=0
DRYRUN=0
RSYNC='rsync --delete-after -rlptDvh'
GPG='gpg'
NAME='unknown'

parse_params() {
    while :; do
        case "${1-}" in
            -h | --help) usage; exit ;;
            -v | --verbose) set -x ;;
            -d | --deploy) DEPLOY=1 ;;
            -a | --all) DEPLOY_ALL=1 ;;
            -s | --sync) SYNC=1 ;;
            -n | --dry-run) DRYRUN=1 ;;
            -?*) die "Unknown option: $1\n$(usage)" ;;
            *) break ;;
        esac
        shift
    done

    if [[ $((DEPLOY + DEPLOY_ALL + SYNC)) -gt 1 ]]; then
        die "Must specify at most one operation"
    fi

    if [[ $DRYRUN -eq 1 ]]; then
        RSYNC+='n'
        GPG+=' -n'
    fi

    if [[ -r /etc/os-release ]]; then
        . /etc/os-release
    fi
}

sync() {
    # Check if the host is "arch"
    if [[ "$(hostname)" != "arch" ]]; then
        while :; do
            echo -n "[!] This machine is not 'arch'. Do you want to continue syncing? [Y/n] "
            read continue_syncing
            continue_syncing="$(echo "$continue_syncing" | tr '[:upper:]' '[:lower:]')"
            if [ -z "${continue_syncing##y*}" ]; then
                rm -rf "$INSTALL_DIR"
                break
            elif [ -z "${continue_syncing##n*}" ]; then
                exit 1
            fi
        done
    fi

    $RSYNC ~/.bashrc ~/.bash_profile ~/.profile ~/.vimrc ~/.vim ~/.gitconfig \
        ~/.tmux.conf ./
    $RSYNC ~/.config/nnn ~/.config/yay ~/.config/bspwm ~/.config/sxhkd \
        ~/.config/cmus ~/.config/dunst ~/.config/polybar ~/.config/rofi \
        ~/.config/alacritty ~/.config/vlc ~/.config/newsboat ~/.config/zathura \
        ~/.config/redshift ~/.config/picom .config/
    $RSYNC ~/.ssh ~/.gnupg private/
    mkdir -p .java/.userPrefs/org && $RSYNC ~/.java/.userPrefs/org/jabref .java/.userPrefs/org/
    mkdir -p .workrave && $RSYNC ~/.workrave/workrave.ini .workrave/
    mkdir -p .elinks && $RSYNC ~/.elinks/elinks.conf .elinks/
    [[ -r /etc/makepkg.conf ]] && \
        $RSYNC /etc/makepkg.conf ./
    [[ -r /etc/xdg/reflector/reflector.conf ]] && \
        $RSYNC /etc/xdg/reflector/reflector.conf ./
    [[ -r /etc/logid.cfg ]] && \
        $RSYNC /etc/logid.cfg ./
    [[ -r /etc/modprobe.d/hid_apple.conf ]] && \
        $RSYNC /etc/modprobe.d/hid_apple.conf ./
    [[ -r /etc/iptables/iptables.rules ]] && \
        $RSYNC /etc/iptables/iptables.rules ./
    [[ -r /etc/lightdm/lightdm-gtk-greeter.conf ]] && \
        $RSYNC /etc/lightdm/lightdm-gtk-greeter.conf ./
    [[ -r /etc/geoclue/geoclue.conf ]] && \
        $RSYNC /etc/geoclue/geoclue.conf ./
    [[ -r /etc/X11/xorg.conf.d/20-nvidia.conf ]] && \
        $RSYNC /etc/X11/xorg.conf.d/20-nvidia.conf ./
    [[ -d /etc/NetworkManager/system-connections ]] && \
        sudo $RSYNC /etc/NetworkManager/system-connections private/
    if [[ $DRYRUN -eq 0 ]]; then
        pacman -Qeq > pkglist
        sudo chown -R $(id -nu):$(id -ng) private
    fi
}

deploy() {
    $RSYNC .bashrc .bash_profile .profile .vimrc .vim .gitconfig .tmux.conf ~/
    $RSYNC .config/nnn ~/.config/
    $RSYNC private/.ssh ~/
    if [[ "$NAME" = 'Arch Linux' ]]; then
        $RSYNC .config/yay ~/.config/
        sudo $RSYNC makepkg.conf /etc/
        sudo $RSYNC reflector.conf /etc/xdg/reflector/
        $RSYNC private/.gnupg ~/
    else
        $GPG --import private/.gnupg/*.asc
    fi
}

deploy_all() {
    deploy

    $RSYNC .config/bspwm .config/sxhkd .config/cmus .config/dunst \
        .config/polybar .config/rofi .config/alacritty .config/vlc \
        .config/newsboat .config/zathura .config/redshift .config/picom \
        ~/.config/
    mkdir -p ~/.java/.userPrefs/org && $RSYNC .java/.userPrefs/org/jabref ~/.java/.userPrefs/org/
    mkdir -p ~/.workrave && $RSYNC .workrave/workrave.ini ~/.workrave/
    mkdir -p ~/.elinks && $RSYNC .elinks/elinks.conf ~/.elinks/
    sudo $RSYNC logid.cfg /etc/
    sudo $RSYNC hid_apple.conf /etc/modprobe.d/
    sudo $RSYNC iptables.rules /etc/iptables/
    sudo $RSYNC lightdm-gtk-greeter.conf /etc/lightdm/
    sudo $RSYNC geoclue.conf /etc/geoclue/
    if lsmod | grep nvidia &>/dev/null; then
        sudo $RSYNC 20-nvidia.conf /etc/X11/xorg.conf.d/
    fi
    sudo $RSYNC private/system-connections /etc/NetworkManager/
    if [[ $DRYRUN -eq 0 ]]; then
        sudo pacman -U --needed --noconfirm private/uiuc-vpn/uiuc-vpn-1.0.0-1-x86_64.pkg.tar.zst
    fi
}

main() {
    parse_params $@

    if [[ $SYNC -eq 1 ]]; then
        sync
    elif [[ $DEPLOY -eq 1 ]]; then
        deploy
    elif [[ $DEPLOY_ALL -eq 1 ]]; then
        deploy_all
    fi
}

main $@
