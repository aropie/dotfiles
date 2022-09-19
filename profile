#!/bin/sh

# Set XDG Base Directory Specification env vars
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CACHE_HOME="$HOME"/.cache
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Uncluttering my $HOME

## X11
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

## Docker
export DOCKER_BIN="$HOME"/.local/bin
export DOCKER_HOST="unix:///run/user/1000/docker.sock"

## AWS
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

## Python
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy

## Node
prefix=${XDG_DATA_HOME}/npm
cache=${XDG_CACHE_HOME}/npm
tmp=${XDG_RUNTIME_DIR}/npm
export NVM_DIR="$XDG_DATA_HOME"/nvm
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

## PostgreSQL
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"

## MySQL
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history

## Wine
export WINEPREFIX="$XDG_DATA_HOME"/wine

export PATH=$PATH:$HOME/.scripts
export PATH=$PATH:$HOME/.local/bin:
export EDITOR='emacsclient -c -a "$@"'
export TERMINAL='kitty'
export MPD_HOST="localhost"
export MPD_PORT="6601"
export SHELL='zsh'
export LPASS_HOME=$HOME/.lpass

[ -f ~/.private_profile ] && . ~/.private_profile
