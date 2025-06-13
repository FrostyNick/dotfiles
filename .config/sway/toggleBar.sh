#!/usr/bin/env bash

if [ "$1" = "-y" ]; then
  prefBar=1;shift
elif [ "$1" = "-n" ]; then
  prefBar=0;shift
else
  prefBar=-1;
fi

bar="$@"
if [ "$bar" = "" ]; then
  $(which notify-send 2> /dev/null || which echo) "No bar to toggle. Using i3bar."
  bar="i3bar"
fi

if [ $prefBar -eq 1 ]; then
  if [[ $(pgrep $bar) ]]; then
    exit 1
  fi
  nm-applet &
  $bar &
  exit 0
elif [ $prefBar -eq 0 ]; then
  killall $bar || exit 1
  killall nm-applet
  exit 0
fi

# notify-send "bar toggle mode"
if [[ $(pgrep $bar) ]]; then
  killall $bar
  killall nm-applet
else
  nm-applet &
  $bar &
fi
