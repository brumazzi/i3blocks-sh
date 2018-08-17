#!/bin/sh

OUT=$(xrandr | grep -v disconnected | grep connected | grep -E -o "[A-Z0-1]{1,7}" | grep [A-Z])
ifs=' '
DISP=($OUT)

if [ "${DISP[1]}" == "" ]; then
#	echo ${DISP[0]}
#else
	xrandr -s 1366x768
	pactl set-card-profile 0 output:analog-stereo
	echo -e "\U1f4bb: (None)"
	exit 0
fi

BTN=0
[[ "$1" ]] && BTN=$1

if [ "$BTN" -eq 1 ]; then
	MON1=$(zenity --list --column=Monitor $OUT)

	if [ "$MON1" == "HDMI1" ]; then
		xrandr --output ${DISP[0]} --mode 1366x768 --output $MON1 --mode 1366x768 --same-as ${DISP[0]}
		pactl set-card-profile 0 output:hdmi-stereo+input:analog-stereo
	else
		xrandr --output ${DISP[0]} --mode 1024x768 --output $MON1 --mode 1024x768 --same-as ${DISP[0]}
	fi
fi

echo -e "<b>\U1f4bb: ${DISP[1]}</b>"
