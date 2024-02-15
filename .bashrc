#
# ~/.bashrc
#

# prompt
PS1='\[\e[2m\][\D{%F %a %I:%M %P}]\[\e[0m\] \[\e[92m\]\u\[\e[0m\] @ \[\e[96m\]\h\[\e[0m\] : \w\n\$ '
PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

# umask
umask 022

# environment variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export PAGER='less -R'
export TERM='xterm-256color'
export GPG_TTY=$(tty)
export BROWSER=google-chrome-stable
export CUPS_USER='uofi\kychou2'
export JAVA_HOME=/usr/lib/jvm/default-runtime
export _JAVA_AWT_WM_NONREPARENTING=1 # java apps issues with non-reparenting WM
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"

# Perl executables
export PATH=$PATH:/usr/bin/vendor_perl

# GTK themes
export GTK_THEME=Kanagawa-Borderless:dark
export GTK_ICON_THEME=Everforest-Dark
export XCURSOR_THEME=phinger-cursors

# input method framework
export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

# vRNI/VeriFlow
export SOURCE_ROOT=/home/kyc/vmware/main
export JAVA_8_HOME=/usr/lib/jvm/java-8-openjdk
export JAVA_11_HOME=/usr/lib/jvm/java-11-openjdk
export JAVA_HOME=$JAVA_11_HOME
export MAVEN_OPTS="-Xmx2252m"
export M2_HOME=/opt/maven
export PATH=$PATH:$M2_HOME/bin

# bash completion
[[ "${BASH#*bash}" != "$BASH" ]] && {
    [[ -r /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
}

# history settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=1000

shopt -s checkwinsize   # check window size after each external command
shopt -s histappend     # append the history file
shopt -s globstar       # globstar **
set -o vi               # start vi mode

# colored less for interactive shell
[[ $- == *i* ]] && {
    export LESS_TERMCAP_mb=$(tput bold; tput setaf 3)
    export LESS_TERMCAP_md=$(tput bold; tput setaf 2)
    export LESS_TERMCAP_me=$(tput sgr0)
    ## use italic (sitm/ritm) instead of underline (smul/rmul)
    export LESS_TERMCAP_us=$(tput sitm; tput setaf 4)
    export LESS_TERMCAP_ue=$(tput ritm; tput sgr0)
    export LESS_TERMCAP_mr=$(tput rev)
    export LESS_TERMCAP_mh=$(tput dim)
}

# aliases
alias l='ls --color=auto -F'
alias la='ls --color=auto -AF'
alias ll='ls --color=auto -lAF'
alias ls='ls --color=auto -F'
alias cp='cp --sparse=auto'
alias rm='trash-put'
alias vi='nvim'
alias vim='nvim'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pacman='pacman --color auto'
alias gdb='gdb -q'
alias valgrind='valgrind --leak-check=full --show-leak-kinds=all --errors-for-leak-kinds=all'
alias mvn_all="mvn clean install -DskipTests -T $(($(nproc) - 1))"
alias mvn_offline="mvn clean install -DskipTests -T $(($(nproc) - 1)) -o -Pdev-local"
alias mvn_fast="mvn clean install -DskipTests -Dspotbugs.skip=true -Dcheckstyle.skip=true -Dpmd.skip=true -T $(($(nproc) - 1))"
alias mvn_fast_offline="mvn clean install -DskipTests -Dspotbugs.skip=true -Dcheckstyle.skip=true -Dpmd.skip=true -T $(($(nproc) - 1)) -o -Pdev-local"
