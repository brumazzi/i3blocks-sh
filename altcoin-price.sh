#!/bin/sh

[[ "$1" ]] || exit 0
coin=$(curl --request GET  https://api.coinmarketcap.com/v1/ticker/$1/)
echo $coin > /tmp/i3-altcoin-$1.tmp

DTA=$(python -c "import json; obj = json.load(open('/tmp/i3-altcoin-$1.tmp','r'))[0]; print(\"%s:%s:%s\" %(obj['name'],obj['price_usd'],obj['percent_change_24h']))")
IFS=':'
coin=($DTA)

if [ "${coin[2]}" -lt 0 ]; then
	color='red'
	icon='\U23ec'
else
	color='green'
	icon='\U23eb'
fi

echo -e "<span color='#C4A000'>${coin[0]}: ${coin[1]}</span> <span color='$color'>${coin[2]}$icon</span>"
