#!/usr/bin/env bash

# workaround to get opacity thanks to: https://github.com/swaywm/sway/issues/7173#issuecomment-1551364058

# swaymsg opacity plus 0.5 || swaymsg opacity 0.5 # (old behavior) toggle opacity: 0.5 or 1
swaymsg opacity plus 0.35 || swaymsg opacity plus 0.15 || swaymsg opacity 0.5 # 0.5 -> 0.85 -> 1
# swaymsg opacity plus 0.25 || swaymsg opacity 0.5 # 0.25 -> 0.5 -> 0.75 -> 1
