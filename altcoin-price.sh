#!/bin/sh

source ~/.config/i3/color.sh

[[ "$1" ]] || exit 0
coins=$(curl https://bitpay.com/api/rates)

echo $coin > /tmp/alt-coin-rate.tmp

DTA=$(python -c "
import json
coin_list = json.load('$coin')
#for coin in coin_list:
#	print(coin)
	# if coin['code'] == '$1':
	#	print(\"%s:%s\" %(coin['name'], coin['rate']))
")
IFS=':'
coin=($DTA)

echo "##############################"
echo $DTA
exit 0

UP_DOWN=$(
python -c "if ${coin[2]} < 0:
	print(0)
else:
	print(1)")

if [ "$UP_DOWN" -eq 1 ]; then
	color=$GREEN
	icon='\U1f4c8'
else
	color=$RED
	icon='\U1f4c9'
fi

[[ "${coin[0]}" ]] && echo -e "<span color='$YELLOW'>${coin[0]}: ${coin[1]}</span> <span color='$color'><b>${coin[2]} $icon</b></span>"
