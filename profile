#!/bin/sh

export PATH=$PATH:$HOME/.scripts
export PATH=$PATH:$HOME/.local/bin:
export EDITOR='emacsclient -c -a "$@"'
export TERMINAL='kitty'
export MPD_HOST="localhost"
export MPD_PORT="6601"
export SHELL='zsh'
export LPASS_HOME=$HOME/.lpass

[ -f ~/.private_profile ] && . ~/.private_profile
