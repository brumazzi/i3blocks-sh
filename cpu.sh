#!/bin/bash

CINFO="/proc/cpuinfo"

CPU_VENDOR=$(cat $CINFO | grep 'vendor_id' | head -1)
CPU_MODEL=$(cat $CINFO | grep 'model name' | head -1)
CPU_MHZ=$(cat $CINFO | grep 'cpu MHz')
CPU_CACHE=$(cat $CINFO | grep 'cache size')

IFS='
'
mhz=($CPU_MHZ)
cache=($CPU_CACHE)

#echo $CPU_VENDOR
#echo $CPU_MODEL

_MAX_GHz=$(echo $CPU_MODEL | grep -E -o "[0-9.GHz]{1,10}" | grep GHz | grep -E -o "[0-9.]{1,5}")

_MAX_GHz="$(echo $_MAX_GHz*1024 | bc)"

_PORC=""
for ((X=0; X<4; X+=1)); do
	let n="$X+1"
	atual=$(echo $mhz[$x] | grep -E -o '[1-9.]{1,10}')
	p=$(echo "(${atual}*100)/$_MAX_GHz" | bc)
	prog[$X]=$(printf "|%5s%3d%%|" "CPU $n" "$p")
	_PORC="$_PORC${prog[$X]}"
done

printf "%s" "$_PORC"
