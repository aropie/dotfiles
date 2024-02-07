#!/bin/sh

setxkbmap -layout us -variant altgr-intl
picom -f -D 1 &
dunst &
emacs --daemon &
unclutter &
numlockx on &
nitrogen --random --set-auto &
sxhkd &
xidlehook --not-when-fullscreen --not-when-audio --timer 600 screen-lock "" &
blueman-applet &
launch_polybar &
polkit-mate-authentication-agent-1 &
flameshot &

Personal
if should_i_be_working; then
  qutebrowser &
  ferdium &
  1password &
fi

exec i3
