#
# ~/.bashrc
#

# prompt
PS1='\[\e[92m\]\u\[\e[0m\] @ \[\e[94m\]\h\[\e[0m\] : \w\n\$ '
PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

# allow foot to jump between prompts
# https://codeberg.org/dnkl/foot/wiki#user-content-jumping-between-prompts
prompt_marker() {
    # shellcheck disable=SC1003
    printf '\e]133;A\e\\'
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }prompt_marker

# umask
umask 022

# environment variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export PAGER='less -R'
export TERM='xterm-256color'
GPG_TTY=$(tty)
export GPG_TTY
export BROWSER=firefox
export CUPS_USER='uofi\kychou2'
export JAVA_HOME=/usr/lib/jvm/default-runtime
export _JAVA_AWT_WM_NONREPARENTING=1 # java apps issues with non-reparenting WM
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"
export NETHACKDIR="$HOME/games/nethack"
export NETHACKOPTIONS="@$NETHACKDIR/.nethackrc"

# Perl executables
export PATH="$PATH:/usr/bin/vendor_perl"

# GTK themes
export GTK_THEME=Kanagawa-Borderless:dark
export GTK_ICON_THEME=Everforest-Dark
export XCURSOR_THEME=phinger-cursors

# bash completion
if [[ "${BASH#*bash}" != "$BASH" ]] &&
    [[ -r /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

# history settings
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=1000

shopt -s checkwinsize # check window size after each external command
shopt -s histappend   # append the history file
shopt -s globstar     # globstar **
set -o vi             # start vi mode

# colored less for interactive shell
if [[ $- == *i* ]]; then
    LESS_TERMCAP_mb=$(
        tput bold
        tput setaf 3
    )
    LESS_TERMCAP_md=$(
        tput bold
        tput setaf 2
    )
    LESS_TERMCAP_me=$(tput sgr0)
    # use italic (sitm/ritm) instead of underline (smul/rmul)
    LESS_TERMCAP_us=$(
        tput sitm
        tput setaf 4
    )
    LESS_TERMCAP_ue=$(
        tput ritm
        tput sgr0
    )
    LESS_TERMCAP_mr=$(tput rev)
    LESS_TERMCAP_mh=$(tput dim)
    export LESS_TERMCAP_mb
    export LESS_TERMCAP_md
    export LESS_TERMCAP_me
    export LESS_TERMCAP_us
    export LESS_TERMCAP_ue
    export LESS_TERMCAP_mr
    export LESS_TERMCAP_mh
fi

# zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init --cmd cd bash)"
fi

# aliases
alias l='ls --color=auto -F'
alias la='ls --color=auto -AF'
alias ll='ls --color=auto -lAF'
alias ls='ls --color=auto -F'
alias cp='cp --sparse=auto'
if command -v trash-put &>/dev/null; then
    alias rm='trash-put'
fi
if command -v nvim &>/dev/null; then
    alias vi='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d'
fi
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pacman='pacman --color auto'
alias gdb='gdb -q'
alias valgrind='valgrind --leak-check=full --show-leak-kinds=all --errors-for-leak-kinds=all'
alias mvn_all='mvn clean install -DskipTests -T $(($(nproc) - 1))'
alias mvn_offline='mvn clean install -DskipTests -T $(($(nproc) - 1)) -o -Pdev-local'
alias mvn_fast='mvn clean install -DskipTests -Dspotbugs.skip=true -Dcheckstyle.skip=true -Dpmd.skip=true -T $(($(nproc) - 1))'
alias mvn_fast_offline='mvn clean install -DskipTests -Dspotbugs.skip=true -Dcheckstyle.skip=true -Dpmd.skip=true -T $(($(nproc) - 1)) -o -Pdev-local'
