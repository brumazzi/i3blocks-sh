#!/bin/bash

DATE=$(curl -v --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')

WDAY="$(echo $DATE | awk -F' ' '{print $1}')"
DAY=$(echo $DATE | awk -F' ' '{print $2}')
MONTH=$(echo $DATE | awk -F' ' '{print $3}')
YEAR=$(echo $DATE | awk -F' ' '{print $4}')
ZI=$(echo $DATE | awk -F' ' '{print $6}')
H=$(echo $DATE | awk -F' ' '{print $5}' | awk -F':' '{print $1}')
M=$(echo $DATE | awk -F' ' '{print $5}' | awk -F':' '{print $2}')
S=$(echo $DATE | awk -F' ' '{print $5}' | awk -F':' '{print $3}')

let H="$H-2"

#echo "$WDAY $DAY $MONTH $YEAR $H:$M:$S"
sudo date +"%d%m%Y %H:%M:%S" -s "$WDAY $DAY $MONTH $YEAR $H:$M:$S"
