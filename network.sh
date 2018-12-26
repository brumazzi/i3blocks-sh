#!/bin/sh

source ~/.config/i3/color.sh
source ~/.config/i3/progress-bar.sh

function network_bytes {
	LAST=$(cat /tmp/network-bytes.tmp)
	if [ $LAST ]; then
		echo "$LAST-$(cat /sys/class/net/$1/statistics/rx_bytes)" | bc
	else
		cat /sys/class/net/$1/statistics/rx_bytes
	fi

	cat /sys/class/net/$1/statistics/rx_bytes > /tmp/network-bytes.tmp
}

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
		ICON="<b>\U1f5a7</b>"
		IP="$EIP"
	else
		ICON="<b>\U1f30e</b>"
		IP="$WIP"
	fi
elif [ "$EIP" ]; then
	ICON="<b>\U1f5a7</b>"
	IP="$EIP"
elif [ "$WLAN" ]; then
	ICON="<b>\U1f30e</b>"
	IP="$WIP"
fi

[[ $IP ]] || exit 0

echo -e "<span color='$YELLOW'>$ICON: $IP</span>"
#echo -e "$ICON: $(progress_bar 10 6 "$(text_split "$IP" 16)" $YELLOW 16)"
