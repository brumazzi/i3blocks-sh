#!/bin/sh

PROCS="conky" #"nm-applet"

for proc in $PROCS; do
	( [[ "$(pgrep $proc)" ]] && echo $proc up ||
		if [ "$proc" == "conky" ]; then
			$proc -c ~/.config/i3/conky.conf
		fi
	) &
done
