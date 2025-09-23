#!/usr/bin/env bash
# config - WARNING: This only works in sway. For other wl-roots / hyprland, you can install wlr-randr and modify code below

# Example (assume you have one monitor in this case):
# wlr-randr --output $(wlr-randr | head -n 1 | awk '{ print $1 }') --scale 1.1

menu="$@"
[ -z "$@" ] && menu=dmenu

num=$(echo -e "0.7\n0.9\n1\n1.16\n1.3\n1.5\n2\n4" | $menu)
nx11=$(jq -n 1/$num || bc <<< "scale=2; 1/$num" || echo $num) # attempt to do 1/$num with jq or bc for consistency

[ $num ] && (swaymsg "output * scale $num") &> /dev/null || wlr-randr --output $(wlr-randr | head -n 1 | awk '{ print $1 }') --scale $num 2> /dev/null || xrandr --output $(xrandr --listactivemonitors | tail -n +2 | $menu | awk '{print $4}') --scale "$nx11"x"$nx11" || (echo "Scale ($num) error"; notify-send "Scale ($num) error")
