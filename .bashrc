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
    IS_COLOR=
    . ~/.etc/bash/bash_colors
fi

if [ -v IS_COLOR ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support for utils and also add handy aliases
if [ -v IS_COLOR ]; then
    [ -n $(which dircolors) ] && eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# enable programmable completion features (you don't need to enable
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#git aliases doesn't support changing environment variables, so we need this alias
alias homeconfig="git --git-dir=$HOME/.homeconfig.git --work-tree=$HOME "
#hijack completion from git command
eval "$(complete -p git | sed 's/git$/homeconfig/')"

#unset IS_COLOR
