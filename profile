#!/bin/sh

export PATH=$PATH:$HOME/.scripts
export EDITOR='emacsclient -c -a "$@"'
export TERMINAL='kitty'
export MPD_HOST="localhost"
export MPD_PORT="6601"
export SHELL='zsh'
export LPASS_HOME=$HOME/.lpass

[ -f ~/.private_profile ] && . ~/.private_profile
