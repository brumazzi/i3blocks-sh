#!/bin/bash

source ~/.config/i3/color.sh

HTML_FMT="<span background='%s' color='%s'>%s</span>"

function progress_bar {
	MAX=$1
	CUR=$2
	TEXT=$3
	COLOR=$4
	COUNT="$5"

	IFS=' '
	_text=($TEXT)

	PORC=$(echo "$CUR*$COUNT/$MAX" | bc)
	printf "<b>"

	I=0
	while [ $I -le $COUNT ]; do
		if [ "${_text[$I]}" == "-" ]; then
			if [ $I -le $PORC ]; then
				printf "$HTML_FMT" $COLOR $COLOR '#'
			else
				printf "$HTML_FMT" $PROGRESS_OFF $PROGRESS_OFF '#'
			fi
		else
			if [ $I -le $PORC ]; then
				printf "$HTML_FMT" $COLOR $PROGRESS_TEXT ${_text[$I]}
			else
				printf "$HTML_FMT" $PROGRESS_OFF $PROGRESS_TEXT ${_text[$I]}
			fi
		fi
		let I=$I+1
	done
	printf "</b>"
}

