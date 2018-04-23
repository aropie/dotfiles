#!/bin/sh

killall polybar
polybar topbar    &
polybar bottombar &
