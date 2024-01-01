#!/bin/bash
source ~/.bash_aliases
pulseaudioE && notify-send "Pulseaudio enabled." || notify-send "Failed to enable pulseaudo."
exit
