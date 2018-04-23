#!/usr/bin/env bash

# power menu
#
# requires:
# - systemd
# - xorg-xset (optional, for locking)
# - rofi

LINES=4
ENTRIES=""
if which xset > /dev/null 2>&1; then
	ENTRIES+="Lock system\\n"
	((++LINES))
fi

ENTRIES+="Suspend system\\n"
ENTRIES+="Hibernate system\\n"
ENTRIES+="Shutdown system\\n"
ENTRIES+="Reboot system"

echo "$LINES"

LAUNCHER="rofi -dmenu -i -lines ${LINES} -hide-scrollbar -p >"

option=$(echo -e "$ENTRIES" | $LAUNCHER | awk '{print $1}' | tr -d '\r\n')
if [ ${#option} -gt 0 ] ; then
	case $option in
		Lock)
			betterlockscreen -l dimblur
			;;
		Suspend)
			systemctl suspend
			;;
		Hibernate)
			systemctl hibernate
			;;
		Shutdown)
			systemctl poweroff
			;;
		Reboot)
			systemctl reboot
			;;
		*)
			;;
	esac
fi
