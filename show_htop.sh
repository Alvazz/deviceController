#!/bin/bash
echo $1
if [ "$1"x == 'skyhub'x ]
then
  echo "connect skyhub"
  sshrun="ssh suxy15@166.111.17.73"
elif [ "$1"x == 'vision'x ]
then
  echo "connect vision"
  sshrun="ssh -p 2222 suxy15@166.111.17.73"
else
  sshrun='echo "Show htop of this screen"'
fi

export DISPLAY=:0
WID=`xdotool search --class "xterm" | head -1`
if [ $WID ]
then
  echo "Closing window $WID"
  pkill -x xterm
fi

xterm -maximized -fs 15&
sleep 1
WID=`xdotool search --class "xterm" | head -1`
xdotool windowfocus $WID
xdotool key ctrl+M
xdotool key Return

sleep 0.5
xdotool type "$sshrun"
xdotool key Return

sleep 0.5
xdotool type 'htop'
xdotool key Return
