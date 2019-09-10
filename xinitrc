#!/bin/sh
setxkbmap latam
setxkbmap -option 'caps:ctrl_modifier,shift:both_capslock' &
compton -f -D 1 &
dunst &
mpd &
unclutter &
numlockx on &
nitrogen --restore &
xcape -e 'Caps_Lock=Escape' &
sxhkd &
xautolock -time 5 -locker screen-lock &
blueman-applet &

exec i3
