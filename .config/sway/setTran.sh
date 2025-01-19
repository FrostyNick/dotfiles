#!/usr/bin/env bash

# src: https://github.com/swaywm/sway/issues/7173#issuecomment-1551364058
#
swaymsg opacity plus 0.1

if [ $? -eq 0 ]; then
        # opacity was not 1, we toggle off
        swaymsg opacity 1
else
        # future? swaymsg opacity plus 0.3 (starting 0.4)
        swaymsg opacity 0.5
fi
