#!/bin/sh

source ~/.config/i3/color.sh

btn=0
[[ "$1" ]] && btn=$1

ETH=$(ifconfig enp2s0f0 | grep inet | grep -E -o '[0-9.]{7,15}')
EIP=$(echo $ETH | awk -F' ' '{print $1}')
EMASK=$(echo $ETH | awk -F' ' '{print $2}')
EBROADCAT=$(echo $ETH | awk -F' ' '{print $3}')

WLAN=$(ifconfig wlp3s0 | grep inet | grep -E -o '[0-9.]{7,15}')
WIP=$(echo $WLAN | awk -F' ' '{print $1}')
WMASK=$(echo $WLAN | awk -F' ' '{print $2}')
WBROADCAT=$(echo $WLAN | awk -F' ' '{print $3}')

IP=""
if [ "$EIP" ] && [ "$WIP" ]; then
	DATE=$(date '+%S')
	MOD=$(echo "$DATE % 2" | bc)
	if [ "$MOD" -eq 1 ]; then
		IP="<b>\U1f5a7</b>: $EIP"
	else
		IP="\U1f30e: $WIP"
	fi
elif [ "$EIP" ]; then
	IP="<b>\U1f5a7</b>: $EIP"
elif [ "$WLAN" ]; then
	IP="\U1f30e: $WIP"
fi

[[ $IP ]] || exit 0
echo -e "<span color='$YELLOW'>$IP</span>"
