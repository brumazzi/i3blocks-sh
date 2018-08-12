#!/bin/sh

BTN=0

[[ "$1" ]] && BTN=$1

if [ "$BTN" -eq 1 ]; then
	(zenity --calendar) &
fi

HOUR=$(date '+%H')
SYMB=""
CLOCK_LIST_00="🕛;🕐;🕑;🕒;🕓;🕔;🕕;🕖;🕗;🕘;🕙;🕚"
CLOCK_LIST_30="🕧;🕜;🕝;🕞;🕟;🕠;🕡;🕢;🕣;🕤;🕥;🕦"
IFS=';'
CLOCKS00=($CLOCK_LIST_00)
CLOCKS30=($CLOCK_LIST_30)

let H="$HOUR % 12"
M=$(date '+%M')
if [ "$M" -le 30 ]; then
	CLOCK="<span color='#ccc'>${CLOCKS00[$H]}</span>"
else
	CLOCK="<span color='#ccc'>${CLOCKS30[$H]}</span>"
fi

if [ "$HOUR" -ge 6 ] && [ "$HOUR" -le 18 ]; then
	SYMB="<span color='yellow'>⛯</span>"
else
	SYMB="<span color='#727FeF'>☪</span>"
fi

CALENDAR="<span color='#fff'>\U1f4c5</span>"

echo -e "$CALENDAR $(date '+%a %d %b') $CLOCK $(date '+%H:%M') <b>$SYMB</b>"
