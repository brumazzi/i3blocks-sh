#!/bin/sh

TEMP=$(sensors | grep Package | grep -E -o "[0-9]{1,3}.[0-9]{1}" | head -1)

IFS='.'
info=($TEMP)

color=''
if [ "${info[0]}" -ge 63 ] && [ "${info[0]}" -le 80 ]; then
	color='yellow'
elif [ "${info[0]}" -gt 80 ]; then
	color='red'
else
	color='green'
fi

echo -n -e "<span color='$color'>\U1f321</span>: $TEMP°"
