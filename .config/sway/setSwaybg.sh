#!/usr/bin/env bash
# config
killall swaybg
# To support more than just png image formats, check dependencies for gdk-pixbuf2 https://archlinux.org/packages/extra/x86_64/gdk-pixbuf2/
# URL: https://wiki.gnome.org/Projects/GdkPixbuf

list=(~/bk*/wallpapers/active/*)
random_index=$(( RANDOM % ${#list[@]} ))
random_file=${list[$random_index]}
echo $random_file
swaybg -i $random_file -m fill
