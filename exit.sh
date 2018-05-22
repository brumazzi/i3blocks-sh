#!/bin/sh

BTN=0
act=""
[[ "$1" ]] && BTN=$1

if [ "$BTN" -eq 1 ]; then
	act=$(zenity --list --text="Sair?" --column="Action" Logout Suspend Hibernate Reboot Shutdown)
	if [ "$act" ]; then
		killall conky -9
#		killall nm-applet
	fi
	if [ "$act" == "Logout" ]; then
		i3-msg exit
	elif [ "$act" == "Suspend" ]; then
		gksudo pm-suspend
	elif [ "$act" == "Hibernate" ]; then
		gksudo pm-hibernate
	elif [ "$act" == "Reboot" ]; then
		gksudo reboot
	elif [ "$act" == "Shutdown" ]; then
		gksudo poweroff
	fi
fi
