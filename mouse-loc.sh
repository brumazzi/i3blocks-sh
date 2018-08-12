#!/bin/bash

MPOS=$(xdotool getmouselocation | grep -E -o "[0-9]{1,4}" | head -2)
IFS='
'
pos=($MPOS)

echo -e "\U1f5b1 ${pos[0]}x${pos[1]}"

