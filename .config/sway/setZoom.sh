#!/usr/bin/env bash
# config - WARNING: This only works in sway. For other wl-roots / hyprland, you can install wlr-randr and modify code below

# Example (assume you have one monitor in this case):
# wlr-randr --output $(wlr-randr | head -n 1 | awk '{ print $1 }') --scale 1.1

menu=$1
[ -z $1 ] && menu=dmenu

num=$(echo -e "0.7\n0.9\n1\n1.16\n1.3\n1.5\n2\n4" | $menu)

[ $num ] && (swaymsg "output * scale $num") # || (notify-send "Canceled launching$num". || echo Canceled launching$num.) 
# [ $num ] && (wlr-randr --output $(wlr-randr | head -n 1 | awk '{ print $1 }') --scale $num)
