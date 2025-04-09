#!/usr/bin/env bash
# launchSlurp.sh - related; for wayland
# sway/hyprland: Flameshot is sometimes fixed with this script on Arch Linux. As of right now, it works without keyboard shortcuts (used to work with keyboard) and additionally on Hyprland the focus is a bit broken for the mouse too (this includes the other window rules workarounds that were added for it to work on Hyprland). Due to many wayland/flameshot breakages, launchSwappy.sh is prioritized.
# X11 = works perfectly.
if [ "$1" = "$(echo -n)" ]; then
  # exec env XDG_CURRENT_DESKTOP=sway /usr/bin/flameshot gui
  env XDG_CURRENT_DESKTOP=sway /usr/bin/flameshot gui
  return
fi
env XDG_CURRENT_DESKTOP=sway /usr/bin/flameshot "$@"
