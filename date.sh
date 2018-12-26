#!/bin/sh

BTN=0

source ~/.config/i3/color.sh

function update_weather {
	if [ "$(cat /tmp/WEATHER.tmp)" -eq "1" ]; then return 1; fi
	printf 1 > /tmp/WEATHER.tmp
	while [ "$(cat /tmp/WEATHER.tmp)" ]; do
		curl http://wttr.in/guariba > /tmp/weather-all.tmp
		WEATHER_INFO="$(cat /tmp/weather-all.tmp | head -4 | tail -n 2)"
		W_STAGE=$(echo $WEATHER_INFO | grep -E -o '[a-zA-Z]{3,32}')
		W_STAGE=$(echo $W_STAGE)
		W_TEMPERATURE=$(echo $WEATHER_INFO | grep -E -o "[m0-9]{5,8}" | awk -F'm' '{print $2}')
		printf "%s;%s" "$W_STAGE" "$W_TEMPERATURE" > /tmp/WEATHER_INFO.tmp
		sleep 300
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
W_STAGE=$(echo $WEAT | grep -E -o '[a-z A-Z]{4,32}' | awk -F' ;' '{print $1}')
W_STAGE=$(echo "print '$W_STAGE'.strip()" | python2)

CLOUD="<span color='$BLUE'>\U2601</span>"
SUN_CLOUD="<span color='$BLUE_GRAY_2'>\U1f324</span>"
SUN="<span color='$YELLOW'>\U1f31e</span>"
SUN_RAIN="<span color='$BLUE_GRAY_1'>\U1f326</span>"
RAIN="<span color='$CYAN'>\U1f327</span>"
LIGHTNING_RAIN="<span color='$YELLOW'>\U26c8</span>"
LIGHTNING="<span color='$YELLOW'>\U1f329</span>"
MOON="<span color='$BLUE_2'>\U1f319</span>"
FOG="<span color='$GRAY'>\U1f32b</span>"

if [ "$W_STAGE" == "Clear" ]; then
	if [ "$HOUR" -ge 6 ] && [ "$HOUR" -le 18 ]; then
		SYMB="$SUN"
	else
		SYMB="$MOON"
	fi
else
	if [ "$W_STAGE" == "Sunny" ]; then
		SYMB="$SUN"
	elif [ "$W_STAGE" == "Partly cloudy" ]; then
		SYMB="$SUN_CLOUD"
	elif [ "$W_STAGE" == "Cloudy" ]; then
		SYMB="$CLOUD"
	elif [ "$W_STAGE" == "Patchy rain possible" ]; then
		SYMB="$SUN_RAIN"
	elif [ "$W_STAGE" == "Torrential rain shower"] || [ "$W_STAGE" == "Moderate rain" ] || [ "$W_STAGE" == "Heavy rain" ] || [ "$W_STAGE" == "Rain" ] || [ "$W_STAGE" == "Light Drizzle" ]; then
		SYMB="$RAIN"
	elif [ "$W_STAGE" == "" ]; then
		SYMB="$LIGHTNING_RAIN"
	elif [ "$W_STAGE" == "" ]; then
		SYMB="$LIGHTNING"
	elif [ "$W_STAGE" == "" ]; then
		SYMB="$MOON"
	elif [ "$W_STAGE" == "" ]; then
		SYMB="$FOG"
	fi
fi


CALENDAR="<span color='#fff'>\U1f4c5</span>"
TCELL[0]=$(echo $WEAT | grep -E -o '[0-9]{1,3}' | head -1)
TCELL[1]=$(echo $WEAT | grep -E -o '[0-9]{1,3}' | tail -n 1)

CELL="$([[ "${TCELL[0]}" -eq "${TCELL[1]}" ]] && echo "${TCELL[0]}" || echo "${TCELL[0]} - ${TCELL[1]}") °C"

echo -e "<b>$CALENDAR $(date '+%a %d %b') $CLOCK $(date '+%H:%M') <b>$SYMB</b> ${CELL}</b>"
