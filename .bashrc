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
export GPG_TTY=$(tty)
export BROWSER=firefox-developer-edition
export RANGER_LOAD_DEFAULT_RC=FALSE
export CUPS_USER='uofi\kychou2'
export TERM='xterm-256color'
#export XDG_CONFIG_HOME="$HOME/.config"

# Bash
[[ -r /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# history settings
HISTCONTROL=ignoreboth
HISTSIZE=5000
HISTFILESIZE=1000
shopt -s histappend
LESSHISTFILE=/dev/null

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# globstar
shopt -s globstar
# start vi mode
set -o vi

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
