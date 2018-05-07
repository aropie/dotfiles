#!/bin/bash

# Take a screenshot:
scrot /tmp/screen.png -z

# Create a blur on the shot:
mogrify -scale 10% -scale 1000% /tmp/screen.png 

# Add the lock to the blurred image:
[[ -f ~/.config/i3/lock.png ]] && convert /tmp/screen.png  ~/.config/i3/lock.png -gravity center -composite /tmp/screen.png

# Pause music (mocp and mpd):
# mocp -P
# mpc pause

# Lock it up!
i3lock -e -i /tmp/screen.png

# If still locked after 20 seconds, turn off screen.
sleep 20 && pgrep i3lock && xset dpms force off
