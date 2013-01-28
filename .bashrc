# ~/.bashrc: executed by bash(2) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#TODO: add support of debian_chroot

#Does terminal support color?
unset IS_COLOR
if [ -n "$(which tput)" -a "$(tput colors)" -gt 0 ]; then
    IS_COLOR=y
    . ~/.etc/bash/bash_colors
fi

HOST_FMT=
[ -n "$SSH_TTY" ] && HOST_FMT='@\h'

UP_LVL=
[ $SHLVL -gt 1 ] && UP_LVL="($(ps -p $PPID -o comm --no-headers))"
#TODO: Move all colors to def
#HAPPY="$Cyan:)$Color_Off"
HAPPY="\[\033[01;36m\]:)\[\033[00m\]"
#SAD="$On_Purple:($Color_Off"
SAD="\[\033[01;35m\]:(\[\033[00m\]"
SMILEY="(((\$?)) && echo -ne '$SAD') || echo -ne '$HAPPY'"
unset HAPPY SAD
PS1="\[\033[01;32m\]\u$UP_LVL$HOST_FMT\[\033[00m\]\$($SMILEY)\[\033[01;34m\]\W\[\033[00m\]\$ "
unset HOST_FMT UP_LVL SMILEY

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support for utils and also add handy aliases
if [ -n "$IS_COLOR" ]; then
    alias ls='ls --color=auto' #ls use dircolors by default
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
alias cscope='cscope -kqUR'
#git aliases doesn't support changing environment variables, so we need this alias
alias homeconfig="git --git-dir=$HOME/.homeconfig.git --work-tree=$HOME "
#hijack completion from git command
$(complete -p git | sed 's/git$/homeconfig/')

#git aliases doesn't support changing environment variables, so we need this alias
alias homeconfig="git --git-dir=$HOME/.homeconfig.git --work-tree=$HOME"
#hijack completion from git command
HOMECONFIG_COMP=$(complete -p git)
if [ -n "$HOMECONFIG_COMP" ]; then
    eval "$(echo $HOMECONFIG_COMP | sed 's/git$/homeconfig/')"
fi
unset HOMECONFIG_COMP

alias cscope='cscope -kqUR'

source ~/.etc/bash/bash_tricks.sh

unset IS_COLOR

