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
ram_monitor &
polkit-mate-authentication-agent-1 &

# Personal
if should_i_be_working; then
    qutebrowser &
    franz &
    1password &
fi

exec i3
