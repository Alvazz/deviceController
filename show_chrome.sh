#!/usr/bin/bash

echo $1

export DISPLAY=:0

ifChrome=`wmctrl -l | grep "Chromium"`
if [ -z "$ifChrome" ]
then
	chromium --kiosk http://10.2.3.164 &
fi

ctab=`wmctrl -l | grep "Chromium" | cut -d ' ' -f 5-`
while [ -z "$(echo $ctab | grep "OctoPrint" | cut -d ' ' -f 1)" ]
do
	xdotool windowfocus `xdotool search --name "$ctab"`
	xdotool key Ctrl+w
	sleep 0.5
	ctab=`wmctrl -l | grep "Chromium" | cut -d ' ' -f 5-`
done

chromium $1
