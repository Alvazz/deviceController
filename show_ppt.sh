#!/bin/bash
echo $1
if [ "$1"x == 'open'x ]; then
    echo "openning ppt"
elif [ "$1"x == 'prev'x ]; then
  echo "connect skyhub"
  sshrun="ssh suxy15@166.111.17.73"
elif [ "$1"x == 'next'x ]; then
  echo "connect vision"
fi

export DISPLAY=:0
WID=`xdotool search --class "powerpoint" | head -1`
if [ $WID ]
then
  echo "Closing window $WID"
  pkill -x xterm
fi

sleep 1
WID=`xdotool search --class "xterm" | head -1`
xdotool windowfocus $WID
xdotool key ctrl+M
xdotool key Return

xdotool key Return

xdotool key Return
