#!/bin/sh

#PROCS="conky nm-applet"

#sh ~/.config/i3/sync_clock.sh

for proc in $PROCS; do
	( 
		sleep 1
		[[ "$(pgrep $proc)" ]] && echo $proc up ||
		if [ "$proc" == "conky" ]; then
			$proc -c ~/.config/i3/conky.conf
		else
			$proc
		fi
	) &
done
