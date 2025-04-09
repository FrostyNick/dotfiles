#!/usr/bin/env bash
# launchFlameshot.sh - related
# Dependencies: grim slurp swappy
# Optional dependencies: tesseract (ocr) wl-clipboard (clipboard doesn't work without this)
# Compared to Flameshot on Wayland (Hyprland/Sway), this is much more reliable and does similar.

# # [ -d "$HOME/Pictures" ] || mkdir -p "$HOME/Pictures"
# s() { # unused code at the moment, which would work if swappy isn't installed
#   # mkdir -p ~/Pictures # run first time
#   cd "$HOME"
#   name="slurp/$(date +%Y%m%d)_$(date +%T)_$(date +%N).jpeg"
#   grim -c -t jpeg -g "$(slurp)" "$name" && notify-send "Saved to ~/$(echo $name | cut -c1-25)   .png"
# }

notify-send "General reminder: Check dependencies and config." # i will add checks later if I remember

[ "$1" = "ocr" ] && (grim -g "$(slurp)" - | tesseract stdin stdout | wl-copy) || (grim -c -t jpeg -g "$(slurp)" - | swappy -f -) # || s || grimshot save area


