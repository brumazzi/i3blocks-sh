#!/bin/bash

ACAD=$(cat /sys/class/power_supply/ACAD/online)
[[ -d "/sys/class/power_supply/BAT0" ]] && BAT=/sys/class/power_supply/BAT0 ||
[[ -d "/sys/class/power_supply/BAT1" ]] && BAT=/sys/class/power_supply/BAT1 || exit 1

function acad_on(){
	printf $ACAD
}

function status(){
	printf $(cat $BAT/status)
}

function full(){
	printf $(cat $BAT/charge_full)
}

function now(){
	printf $(cat $BAT/charge_now)
}

function porcent(){
	max=$(full)
	now=$(now)
	let pct="$now*100/$max"
	printf "${pct}"
}

SYMB=
if [ "$(acad_on)" == "1" ]; then
	SYMB="\U1f50c"
else
	SYMB="\U1f50b"
fi

COLOR="green"
PORC=$(porcent)
if [ "$PORC" -le 15 ]; then
	COLOR="red"
elif [ "$PORC" -le 30 ]; then
	COLOR="yellow"
fi

echo -e "<span color='$COLOR'>$SYMB: $PORC%</span>"
