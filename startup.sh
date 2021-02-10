#!/bin/sh

#PROCS="conky nm-applet"

#sh ~/.i3blocks/sync_clock.sh

cd ~/.i3blocks/
git push origin master
cd -

for proc in $PROCS; do
	( 
		sleep 1
		[[ "$(pgrep $proc)" ]] && echo $proc up ||
		if [ "$proc" == "conky" ]; then
			$proc -c ~/.i3blocks/conky.conf
		else
			$proc
		fi
	) &
done
