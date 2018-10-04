#!/bin/bash

source ~/.config/i3/color.sh

MEM_FILE="/proc/meminfo"
MEM_TEXT_L="- - M E M O R Y - -"
SWP_TEXT_L="- - - S W A P - - -"
IFS=' '
MEM_TEXT=($MEM_TEXT_L)
SWP_TEXT=($SWP_TEXT_L)

MEM_MAX=$(cat $MEM_FILE | grep MemTotal | grep -E -o '[0-9]{1,10}')
MEM_FREE=$(cat $MEM_FILE | grep MemFree | grep -E -o '[0-9]{1,10}')
MEM_AVAL=$(cat $MEM_FILE | grep MemAvailable | grep -E -o '[0-9]{1,10}')

SWAP_MAX=$(cat $MEM_FILE | grep SwapTotal | grep -E -o '[0-9]{1,10}')
SWAP_FREE=$(cat $MEM_FILE | grep SwapFree | grep -E -o '[0-9]{1,10}')

function porcent_mem {
	PORC=$(echo "$MEM_AVAL*100/$MEM_MAX" | bc -l)
	echo $PORC | cut -c 1-6
}

function porcent_swap {
	PORC=$(echo "$SWAP_FREE*100/$SWAP_MAX" | bc -l)
	echo $PORC | cut -c 1-6
}

function progress_mem {
	MAX=$1
	CUR=$2
	PORC=$(echo "$CUR*10/$MAX" | bc )
	let i=0
	echo -n "<b>" 
	while [ $i -lt 10 ]; do
		if [ "${MEM_TEXT[$i]}" == "-" ]; then
			if [ $i -le $PORC ]; then
				echo -n "<span background='$PROGRESS_MEM_BG' color='$PROGRESS_MEM_BG'>#</span>"
			else
				echo -n "<span background='$PROGRESS_OFF' color='$PROGRESS_OFF'>#</span>"
			fi
		else
			if [ $i -le $PORC ]; then
				echo -n "<span background='$PROGRESS_MEM_BG' color='$PROGRESS_TEXT'>${MEM_TEXT[$i]}</span>"
			else
				echo -n "<span background='$PROGRESS_OFF' color='$PROGRESS_TEXT'>${MEM_TEXT[$i]}</span>"
			fi
		fi
		let i=$i+1
	done
	echo -n "</b>" 
}

function progress_swap {
	MAX=$1
	CUR=$2
	PORC=$(echo "$CUR*10/$MAX" | bc )
	let i=0
	echo -n "<b>" 
	while [ $i -lt 10 ]; do
		if [ "${SWP_TEXT[$i]}" == "-" ]; then
			if [ $i -le $PORC ]; then
				echo -n "<span background='$PROGRESS_SWAP_BG' color='$PROGRESS_SWAP_BG'>#</span>"
			else
				echo -n "<span background='$PROGRESS_OFF' color='$PROGRESS_OFF'>#</span>"
			fi
		else
			if [ $i -le $PORC ]; then
				echo -n "<span background='$PROGRESS_SWAP_BG' color='$PROGRESS_TEXT'>${SWP_TEXT[$i]}</span>"
			else
				echo -n "<span background='$PROGRESS_OFF' color='$PROGRESS_TEXT'>${SWP_TEXT[$i]}</span>"
			fi
		fi
		let i=$i+1
	done
	echo -n "</b>" 
}

if [ "$1" == "MEM" ]; then
	progress_mem $MEM_MAX $MEM_AVAL
elif [ "$1" == "SWAP" ]; then
	progress_swap $SWAP_MAX $SWAP_FREE
fi
