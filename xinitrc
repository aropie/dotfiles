#!/bin/sh
[ -f ~/.profile ] && . ~/.profile

setxkbmap -layout us -variant altgr-intl
setxkbmap -option 'caps:ctrl_modifier,shift:both_capslock' &
picom -f -D 1 &
dunst &
emacs --daemon
unclutter &
numlockx on &
nitrogen --random --set-auto &
xcape -e 'Caps_Lock=Escape' &
sxhkd &
xautolock -time 3 -locker screen-lock  -cornersize 50 -corners -000 -detectsleep -notify 30 -notifier "notify-send -u normal -t 3000 'Autolock' 'Locking screen in 30 seconds'"&
blueman-applet &
launch_polybar &

# Personal
qutebrowser &
franz &

# Only on workdays
if should_i_be_working;
then
    zoom &
    /opt/Tandem/tandem &
fi

exec i3
