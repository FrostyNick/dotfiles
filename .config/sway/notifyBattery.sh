#!/usr/bin/env bash
# FIX: Below doesn't check charging/discharging status.
MIN=25
MAX=80
while sleep 20; do
	# notify-send "inside loop"
	for bat in /sys/class/power_supply/BAT*; do
		level=$(< $bat/capacity)
		[[ $level -le $MIN ]] && grep -iq discharging ${bat}/status && notify-send "Battery under $MIN. Plug in the adapter ASAP"
		[[ $level -gt $MAX ]] && grep -iq charging ${bat}/status && notify-send "Battery above $MAX. Unplug adapter to extend future battery life." && sleep 120
	done
done

