#!/bin/bash

CLOCK=$(curl 'https://time.is/pt_br/Brasília' | grep 'clock0_bg' | grep -E -o '[0-90-9:0-90-9:0-90-9]{6,8}')

#echo $CLOCK

#WDAY="$(echo $DATE | awk -F' ' '{print $1}')"
#DAY=$(echo $DATE | awk -F' ' '{print $2}')
#MONTH=$(echo $DATE | awk -F' ' '{print $3}')
#YEAR=$(echo $DATE | awk -F' ' '{print $4}')
#ZI=$(echo $DATE | awk -F' ' '{print $6}')
H=$(echo $CLOCK | awk -F':' '{print $1}')
M=$(echo $CLOCK | awk -F':' '{print $2}')
S=$(echo $CLOCK | awk -F':' '{print $3}')

echo #CLOCK

#echo "$WDAY $DAY $MONTH $YEAR $H:$M:$S"
#sudo date +"%d%m%Y %H:%M:%S" -s "$WDAY $DAY $MONTH $YEAR $H:$M:$S"
sudo date +"%H:%M:%S" -s "$H:$M:$S"
