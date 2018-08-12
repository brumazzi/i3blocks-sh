#!/bin/sh

btn=0
[[ "$1" ]] && btn=$1

IP=$(ifconfig wlp3s0 | grep inet | head -1 | grep -E -o '[0-9]{1,3}.{1,3}.{1,3}.{1,3}[^a-z]' | head -1)

echo -e "\U1f30e: $IP"
