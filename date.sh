#!/bin/sh

BTN=0

[[ "$1" ]] && BTN=$1

if [ "$BTN" -eq 1 ]; then
	(zenity --calendar) &
fi

HOUR=$(date '+%H')
SYMB=""
CLOCK_LIST_00="🕛;🕐;🕑;🕒;🕓;🕔;🕕;🕖;🕗;🕘;🕙;🕚"
CLOCK_LIST_30=";🕧;🕜;🕝;🕞;🕟;🕠;🕡;🕢;🕣;🕤;🕥;🕦"
IFS=';'
CLOCKS00=($CLOCK_LIST_00)
CLOCKS30=($CLOCK_LIST_30)

let H=$HOUR % 12
let M=$(date '+%M')
if [ "$M" -l 30 ]; then
	CLOCK="${CLOCKS00[$H]}"
else
	CLOCK="${CLOCKS30[$H]}"
fi

if [ "$HOUR" -ge 6 ] && [ "$HOUR" -le 18 ]; then
	SYMB="<span color='yellow'>⛯</span>"
else
	SYMB="<span color='#727FeF'>☪</span>"
fi

echo -e "<b>\U1f4c5</b> $(date '+%a %d %b')<b> $CLOCK </b>$(date '+%H:%M') <b>$SYMB</b>"
