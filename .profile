# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ] ; then
    PATH="$PATH:$HOME/.bin"
fi

#set some preference
export EDITOR=vim
export PAGER=less
export TERMINAL=xterm
