#!/bin/bash

# earth owl mouse position

source ~/.config/i3/color.sh

MPOS=$(xdotool getmouselocation | grep -E -o "[0-9]{1,4}" | head -2)
IFS='
'
pos=($MPOS)

if	[ "${pos[0]}" -ge 4 ] && [ "${pos[1]}" -ge 4 ] &&
	[ "${pos[0]}" -le 24 ] && [ "${pos[1]}" -le 24 ] ; then
	echo "<span color='$EARTH_OWL'><b>Hoohoooo!</b></span>"
	exit 0
fi

echo -e "<span color='$EARTH_OWL'><b>\U1f989</b></span> ${pos[0]}x${pos[1]}"
