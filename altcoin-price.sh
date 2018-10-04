#!/bin/sh

source ~/.config/i3/color.sh

[[ "$1" ]] || exit 0
coin=$(curl --request GET  https://api.coinmarketcap.com/v1/ticker/$1/) || exit 0
echo $coin > /tmp/i3-altcoin-$1.tmp

DTA=$(python -c "import json; obj = json.load(open('/tmp/i3-altcoin-$1.tmp','r'))[0]; print(\"%s:%s:%s\" %(obj['name'],obj['price_usd'],obj['percent_change_24h']))")
IFS=':'
coin=($DTA)

UP_DOWN=$(python -c "if ${coin[2]} < 0: print(0)
else: print(1)")

if [ "$UP_DOWN" -eq 1 ]; then
	color=$GREEN
	icon='\U1f4c8'
else
	color=$RED
	icon='\U1f4c9'
fi

[[ "${coin[0]}" ]] && echo -e "<span color='$YELLOW'>${coin[0]}: ${coin[1]}</span> <span color='$color'><b>${coin[2]} $icon</b></span>"
