#!/bin/sh

setxkbmap -layout us -variant altgr-intl
picom -f -D 1 &
dunst &
emacs --daemon &
unclutter &
numlockx on &
nitrogen --random --set-auto &
sxhkd &
xautolock -time 3 -locker screen-lock  -cornersize 50 -corners -000 -detectsleep -notify 30 -notifier "notify-send -u normal -t 3000 'Autolock' 'Locking screen in 30 seconds'"&
blueman-applet &
launch_polybar &
ram_monitor &
polkit-mate-authentication-agent-1 &

# Personal
qutebrowser &
franz &

# Only on workdays


exec i3
