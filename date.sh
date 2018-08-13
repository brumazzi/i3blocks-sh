#!/bin/sh

BTN=0

function update_weather {
	if [ "$(cat /tmp/WEATHER.tmp)" -eq "1" ]; then return 1; fi
	printf 1 > /tmp/WEATHER.tmp
	while [ "$(cat /tmp/WEATHER.tmp)" ]; do
		WEATHER_INFO="$(curl http://wttr.in/nova_andradina | head -4 | tail -n 2)"
		W_STAGE=$(echo $WEATHER_INFO | head -1 | grep -E -o "[a-zA-Z]{3,32}")
		W_TEMPERATURE=$(echo $WEATHER_INFO | tail -n 1 | grep -E -o "[m0-9]{5,8}" | awk -F'm' '{print $2}')
		printf "%s;%s" "$W_STAGE" "$W_TEMPERATURE" > /tmp/WEATHER_INFO.tmp
		sleep 100
	done
}

update_weather &

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

WEAT="$(cat /tmp/WEATHER_INFO.tmp)"
W_STAGE=$(echo $WEAT | grep -E -o '[a-zA-Z]{4,32}')

SUN="<span color='yellow'>\U1f31e</span>"
MOON="<span color='#727fef'>☪</span>"
SUN_CLOUD="<span color='#449FFF'>\U1f324</span>"
RAIN="<span color='#3465A4'>\U1f327</span>"
SUN_RAIN="<span color='#89DFEB'>\U1f326</span>"

[[ "$W_STAGE" == "Clear" ]] &&
	if [ "$HOUR" -ge 6 ] && [ "$HOUR" -le 18 ]; then
		SYMB="$SUN"
	else
		SYMB="$MOON"
	fi ||
	if [ "$W_STAGE" == "Sunny" ]; then
		SYMB="$SUN"
	elif [ "$W_STAGE" == "Partly cloudy" ]; then
		SYMB="$SUN_CLOUD"
	fi

CALENDAR="<span color='#fff'>\U1f4c5</span>"
CELL="$(echo $WEAT | grep -E -o '[0-9]{1,3}' | head -1) - $(echo $WEAT | grep -E -o '[0-9]{1,3}' | tail -n 1) °C"

echo -e "$CALENDAR $(date '+%a %d %b') $CLOCK $(date '+%H:%M') <b>$SYMB</b> ${CELL}"
