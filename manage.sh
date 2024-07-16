#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
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
    -r, --cp-root   Copy CLI configs to /root/
    -n, --dry-run   Dry run
EOF
}

DEPLOY=0
DEPLOY_ALL=0
SYNC=0
CP_ROOT=1
DRYRUN=0
RSYNC=('rsync' '--delete-after' '-rlptDvh')
GPG='gpg'
NAME='unknown'

CLI_HOME_CONFIGS=(
    .bash_profile
    .bashrc
    .gdbinit
    .gitconfig
    .profile
    .tmux.conf
)

CLI_CONFIGS=(
    .config/nvim
    .config/paru
    .config/yazi
)

GUI_HOME_CONFIGS=(
    .gtkrc-2.0
    .icons
    .xinitrc
)

GUI_CONFIGS=(
    .config/bspwm
    .config/chrome-flags.conf
    .config/cmus
    .config/code-flags.conf
    .config/colorscheme.css
    .config/colorscheme.sh
    .config/dunst
    .config/electron-flags.conf
    .config/flameshot
    .config/foot
    .config/gammastep
    .config/garglk.ini
    .config/gtk-3.0
    .config/gtk-4.0
    .config/hypr
    .config/mimeapps.list
    .config/newsboat
    .config/picom
    .config/polybar
    .config/redshift
    .config/river
    .config/rofi
    .config/safeeyes
    .config/sway
    .config/swaylock
    .config/sxhkd
    .config/systemd
    .config/vlc
    .config/waybar
    .config/wlogout
    .config/xsettingsd
    .config/zathura
)

parse_params() {
    while :; do
        case "${1-}" in
        -h | --help)
            usage
            exit
            ;;
        -v | --verbose) set -x ;;
        -d | --deploy) DEPLOY=1 ;;
        -a | --all) DEPLOY_ALL=1 ;;
        -s | --sync) SYNC=1 ;;
        -r | --cp-root) CP_ROOT=1 ;;
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
        RSYNC+=('-n')
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
            read -r continue_syncing
            continue_syncing="$(echo "$continue_syncing" | tr '[:upper:]' '[:lower:]')"
            if [ -z "${continue_syncing##y*}" ]; then
                rm -rf "$INSTALL_DIR"
                break
            elif [ -z "${continue_syncing##n*}" ]; then
                exit 1
            fi
        done
    fi

    for item in "${CLI_HOME_CONFIGS[@]}"; do "${RSYNC[@]}" ~/"$item" ./; done
    for item in "${GUI_HOME_CONFIGS[@]}"; do "${RSYNC[@]}" ~/"$item" ./; done
    for item in "${CLI_CONFIGS[@]}"; do "${RSYNC[@]}" ~/"$item" .config/; done
    for item in "${GUI_CONFIGS[@]}"; do "${RSYNC[@]}" ~/"$item" .config/; done
    "${RSYNC[@]}" ~/.ssh ~/.gnupg ~/.config/mudlet private/
    mkdir -p .java/.userPrefs/org && "${RSYNC[@]}" ~/.java/.userPrefs/org/jabref .java/.userPrefs/org/
    [[ -r /etc/makepkg.conf ]] &&
        "${RSYNC[@]}" /etc/makepkg.conf ./
    [[ -r /etc/xdg/reflector/reflector.conf ]] &&
        "${RSYNC[@]}" /etc/xdg/reflector/reflector.conf ./
    [[ -r /etc/logid.cfg ]] &&
        "${RSYNC[@]}" /etc/logid.cfg ./
    [[ -r /etc/modprobe.d/hid_apple.conf ]] &&
        "${RSYNC[@]}" /etc/modprobe.d/hid_apple.conf ./
    [[ -r /etc/iptables/iptables.rules ]] &&
        "${RSYNC[@]}" /etc/iptables/iptables.rules ./
    [[ -r /etc/nftables.conf ]] &&
        "${RSYNC[@]}" /etc/nftables.conf ./
    [[ -r /etc/geoclue/geoclue.conf ]] &&
        "${RSYNC[@]}" /etc/geoclue/geoclue.conf ./
    [[ -r /etc/X11/xorg.conf.d/20-nvidia.conf ]] &&
        "${RSYNC[@]}" /etc/X11/xorg.conf.d/20-nvidia.conf ./
    [[ -d /etc/NetworkManager/system-connections ]] &&
        sudo "${RSYNC[@]}" /etc/NetworkManager/system-connections private/
    if [[ $DRYRUN -eq 0 ]]; then
        pacman -Qeq >pkglist
        sudo chown -R "$(id -nu):$(id -ng)" private
    fi
}

deploy() {
    for item in "${CLI_HOME_CONFIGS[@]}"; do "${RSYNC[@]}" "$item" ~/; done
    for item in "${CLI_CONFIGS[@]}"; do "${RSYNC[@]}" "$item" ~/.config/; done
    "${RSYNC[@]}" private/.ssh ~/
    if [[ "$NAME" = 'Arch Linux' ]]; then
        sudo "${RSYNC[@]}" makepkg.conf /etc/
        sudo "${RSYNC[@]}" reflector.conf /etc/xdg/reflector/
        "${RSYNC[@]}" private/.gnupg ~/
    else
        $GPG --import private/.gnupg/*.asc
    fi
}

deploy_all() {
    deploy

    for item in "${GUI_HOME_CONFIGS[@]}"; do "${RSYNC[@]}" "$item" ~/; done
    for item in "${GUI_CONFIGS[@]}"; do "${RSYNC[@]}" "$item" ~/.config/; done
    "${RSYNC[@]}" private/mudlet ~/.config/
    mkdir -p ~/.java/.userPrefs/org && "${RSYNC[@]}" .java/.userPrefs/org/jabref ~/.java/.userPrefs/org/
    sudo "${RSYNC[@]}" logid.cfg /etc/
    sudo "${RSYNC[@]}" hid_apple.conf /etc/modprobe.d/
    sudo "${RSYNC[@]}" iptables.rules /etc/iptables/
    sudo "${RSYNC[@]}" nftables.conf /etc/
    sudo "${RSYNC[@]}" geoclue.conf /etc/geoclue/
    if lsmod | grep nvidia &>/dev/null; then
        sudo "${RSYNC[@]}" 20-nvidia.conf /etc/X11/xorg.conf.d/
    fi
    sudo "${RSYNC[@]}" private/system-connections /etc/NetworkManager/
}

copy_cli_to_root() {
    for item in "${CLI_HOME_CONFIGS[@]}"; do sudo "${RSYNC[@]}" "$item" /root/; done
    for item in "${CLI_CONFIGS[@]}"; do sudo "${RSYNC[@]}" "$item" /root/.config/; done
}

main() {
    parse_params "$@"

    if [[ $SYNC -eq 1 ]]; then
        sync
    elif [[ $DEPLOY -eq 1 ]]; then
        deploy
    elif [[ $DEPLOY_ALL -eq 1 ]]; then
        deploy_all
    fi

    if [[ $CP_ROOT -eq 1 ]]; then
        copy_cli_to_root
    fi
}

main "$@"
