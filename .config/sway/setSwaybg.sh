#!/usr/bin/env sh
# config
oldids="$(pgrep swaybg)"

# To support more than just png image formats, check dependencies for gdk-pixbuf2 https://archlinux.org/packages/extra/x86_64/gdk-pixbuf2/
# URL: https://wiki.gnome.org/Projects/GdkPixbuf

list=(~/bk*/wallpapers/active/*)
random_index=$(( RANDOM % ${#list[@]} ))
random_file=${list[$random_index]}
echo $random_file
swaybg -i $random_file -m fill &

# kill old processes after new image is loaded
sleep 2
echo "$oldids" | xargs -r kill
# BUG: Seems like a bug introduced in sway. It creates 2 processes (it was one before). The extra unneeded process is killed below. Downgrading swaybg doesn't do anything. Future problem.
kill $(ps aux | grep swaybg | grep -v "grep\|-i" | awk '{print $2}')
