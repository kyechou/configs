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
export EDITOR=vim
export VISUAL=vim
export PAGER='less -R'
export GPG_TTY=$(tty)
export BROWSER=firefox-developer-edition
export CUPS_USER='uofi\kychou2'
export TERM='xterm-256color'
export JAVA_HOME=/usr/lib/jvm/default-runtime
export _JAVA_AWT_WM_NONREPARENTING=1 # java apps issues with non-reparenting WM

# asp (arch build system)
export ASPROOT="$HOME/cs/archlinux/abs"
export ASPCACHE="$ASPROOT/cache"

# nnn
[[ -n "$NNNLVL" ]] && PS1="\[\e[2m\](N $NNNLVL)\[\e[0m\] $PS1"
export NNN_OPTS='cdeEQRU'
export NNN_OPENER=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/plugins/nuke
export GUI=1
export NNN_PLUG='p:getplugs;o:fzopen;f:fzcd;s:suedit'
export NNN_COLORS='#6f6f6f6f'
export NNN_FCOLORS='c1e26f2900607bf7c6d6abc4'
export NNN_ARCHIVE='\\.(7z|bz2|gz|tar|tgz|xz|zip)$'
export NNN_TRASH=1
export NNN_FIFO='/tmp/nnn.fifo'

# vRNI/VeriFlow
export SOURCE_ROOT=/home/kyc/vmware/main

# bash
[[ "${BASH#*bash}" != "$BASH" ]] && \
    [[ -r /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

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
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pacman='pacman --color auto'
alias gdb='gdb -q'
alias valgrind='valgrind --leak-check=full --show-leak-kinds=all \
                         --errors-for-leak-kinds=all'
alias sshweb='ssh kychou2@web.illinois.edu'
