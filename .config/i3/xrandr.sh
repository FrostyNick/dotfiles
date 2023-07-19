#!/bin/bash
# sleep 5
# notify-send "xrandr mode sus"
xrandr --output DP-2 --mode 1360x768 --panning 1360x768 && sleep 5
xrandr --output DP-2 --mode 1360x768 --panning 1280x720 --transform 1,0,-80,0,1,-48,0,0,1
