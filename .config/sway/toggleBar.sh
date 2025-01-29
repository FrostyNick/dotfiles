#!/usr/bin/env bash

bar=$1
if [ "$1" = "" ]; then
  notify-send "No bar to toggle. Using i3bar."
  bar="i3bar"
fi


if [[ $(pgrep $bar) ]]; then
  killall $bar
  killall nm-applet
else
  nm-applet &
  $bar &
fi
