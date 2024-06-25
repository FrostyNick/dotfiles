#!/usr/bin/env bash
list=(~/Pictures/wallpapers/*)
random_index=$(( RANDOM % ${#list[@]} ))
random_file=${list[$random_index]}
echo $random_file
swaybg -i $random_file -m fill
