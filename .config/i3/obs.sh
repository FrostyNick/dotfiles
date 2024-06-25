#!/usr/bin/env bash
source ~/.bash_aliases

swaync-client --dnd-on
nonoti && obs ; noti && swaync-client --dnd-off
notify-send "streamer mode off"
# obs
