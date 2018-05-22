#!/bin/sh

kmap=$(cat ~/.config/i3/keymap-default)
BTN=0
[[ "$1" ]] && BTN="$1"

if [ "$BTN" -eq 1 ]; then
	if [ "$kmap" == "agr_i" ]; then
		setxkbmap -layout us -variant alt-intl
		kmap=alt_i
	elif [ "$kmap" == "alt_i" ]; then
		setxkbmap -layout us -variant altgr-intl
		kmap=agr_i
	fi
fi

echo $kmap > ~/.config/i3/keymap-default
echo -e "\U2328: $kmap"
