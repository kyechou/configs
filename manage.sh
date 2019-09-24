#!/bin/bash

set -e

[ $UID -eq 0 ] && { \
    echo '[!] Please run this script without root privilege' >&2
    exit 1
}
SCRIPT_DIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"
cd "$SCRIPT_DIR"

usage()
{
    echo "[!] Usage: $0 [OPTIONS]" >&2
    echo '    Options:' >&2
    echo '        -a    deploy everything (as an Arch Linux desktop)' >&2
    echo '        -d    deploy as in a CLI environment' >&2
    echo '        -n    dry-run' >&2
    echo '        -s    sync everything (as an Arch Linux desktop)' >&2
}

DEPLOY_ALL=0
DEPLOY=0
SYNC=0
DRYRUN=0
while getopts 'adnsh' op; do
    case $op in
        a)
            DEPLOY=1
            DEPLOY_ALL=1 ;;
        d)
            DEPLOY=1 ;;
        n)
            DRYRUN=1 ;;
        s)
            SYNC=1 ;;
        h|*)
            usage
            exit 1 ;;
    esac
done

[[ ($DEPLOY_ALL -eq 1 || $DEPLOY -eq 1) && ($SYNC -eq 1) ]] && { \
    echo '[!] -s cannot be used with -a or -d at the same time' >&2
    usage
    exit 1
}

RSYNC='rsync --delete-after -rlptDvh'
[[ $DRYRUN -eq 1 ]] && RSYNC+='n'
GPG='gpg'
[[ $DRYRUN -eq 1 ]] && GPG+=' -n'

NAME='unknown'
[[ -r /etc/os-release ]] && . /etc/os-release

[[ $DEPLOY -eq 1 ]] && { \
    $RSYNC .bashrc .bash_profile .profile .vimrc .vim .gitconfig .tmux.conf ~/
    $RSYNC .config/ranger ~/.config/
    [[ "$NAME" = 'Arch Linux' && $DRYRUN -eq 0 ]] && sudo pacman -U \
        --needed --noconfirm pacleaf/pacleaf-1.0.0-1-x86_64.pkg.tar.xz
    $RSYNC private/.ssh ~/
    if [[ "$NAME" = 'Arch Linux' ]]; then
        $RSYNC private/.gnupg ~/
        sudo $RSYNC makepkg.conf /etc/
    else
        $GPG --import private/.gnupg/*.asc
    fi
}

[[ $DEPLOY_ALL -eq 1 ]] && { \
    $RSYNC .config/cmus .config/dunst .config/polybar .config/termite \
        .config/zathura .config/vlc ~/.config/
    mkdir -p ~/.java/.userPrefs/org && \
        $RSYNC .java/.userPrefs/org/jabref ~/.java/.userPrefs/org/
    $RSYNC .i3 .Xmodmap ~/
    sudo $RSYNC iptables.rules /etc/iptables/
    sudo $RSYNC lightdm-gtk-greeter.conf /etc/lightdm/
    sudo $RSYNC private/system-connections /etc/NetworkManager/
    [[ $DRYRUN -eq 0 ]] && sudo pacman -U --needed --noconfirm \
        private/uiuc-vpn/uiuc-vpn-1.0.0-1-x86_64.pkg.tar.xz
}

[[ $SYNC -eq 1 ]] && { \
    $RSYNC ~/.bashrc ~/.bash_profile ~/.profile ~/.vimrc ~/.vim ~/.gitconfig \
        ~/.tmux.conf ~/.i3 ~/.Xmodmap ./
    $RSYNC ~/.config/cmus ~/.config/dunst ~/.config/polybar ~/.config/ranger \
        ~/.config/termite ~/.config/zathura ~/.config/vlc .config/
    mkdir -p .java/.userPrefs/org && \
        $RSYNC ~/.java/.userPrefs/org/jabref .java/.userPrefs/org/
    pacman -Qeq > pkglist
    [[ -r /etc/iptables/iptables.rules ]] && \
        $RSYNC /etc/iptables/iptables.rules ./
    [[ -r /etc/makepkg.conf ]] && \
        $RSYNC /etc/makepkg.conf ./
    [[ -r /etc/lightdm/lightdm-gtk-greeter.conf ]] && \
        $RSYNC /etc/lightdm/lightdm-gtk-greeter.conf ./
    $RSYNC ~/.ssh ~/.gnupg private/
    [[ -d /etc/NetworkManager/system-connections ]] && \
        sudo $RSYNC /etc/NetworkManager/system-connections private/
    [[ $DRYRUN -eq 0 ]] && sudo chown -R $(id -nu):$(id -ng) private
}

exit 0
