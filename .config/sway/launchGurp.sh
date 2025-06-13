#!/usr/bin/env bash
# launchFlameshot.sh - related
# Compared to Flameshot on Wayland (Hyprland/Sway), this is much more reliable and does similar. See ~/.config/swappy/config for swappy config.
# WARNING:
# - Depending on your setup, you may want to replace $bar variable below with your bar (waybar, swaybar, etc.) .. it gets default bar from $bar in sway config (or swaybar) at the moment.
# - Not tested on multiple displays.
# - Image holding is EXPERIMENTAL and not very reliable: If the image doesn't stay while taking a screenshot, you may need to increase the amount of time in sleep below / decrease quality of the first grim command that runs.

deps=("swayimg" "grim" "slurp" "awk" "jq") # swayimg can in theory be replaced with your preferred image viewer; preferably taking your full screen and allowing `grim` on top of full screen.
ec=$(which notify-send 2> /dev/null || which echo)

for dep in "${deps[@]}"; do
  if ! command -v "$dep" 2> /dev/null; then
    $ec "launchGurp.sh error: $dep is not installed."; exit 1
  fi
done
command -v wl-copy || ($ec "launchGurp: Image clipboard broken! Install wl-clipboard / wl-copy to fix." &)

live-screenshot() {
  grim -c -t jpeg -g "$(slurp -b 000000cc -c 005500cc;kill $(ps aux | grep swayimg | grep -v grep | tail -n 1 | awk '{print $2}'))" - | swappy -f -
}

hold-screenshot() {
  # grim -c -l 9 - | swayimg - # Quality from 0-9
  grim -c - | swayimg -
}

full-screenshot() {
  hold-screenshot &
  # pid=$!
  bar=$(grep "set \$bar" $HOME/.config/sway/config | cut -d ' ' -f 3- || echo swaybar)
 # | rev | awk '{print $1}' | rev)
  $HOME/.config/sway/toggleBar.sh -n "$bar"
  barExit=$?
  # wait "$pid"
  sleep 0.8 # for some reason `live-screenshot` and `hold-screenshot` (either order) need to be around 0.6+ seconds apart if one of them is in the background to consistantly work with the delay in grim.

  live-screenshot
  if [ $barExit -eq 0 ]; then # success = it ran earlier, so bring it back like it was before
    $HOME/.config/sway/toggleBar.sh -y "$bar"
  fi
}

ocr-screenshot() {
  if ! command -v tesseract 2> /dev/null; then
    $ec "launchGurp: tesseract is needed in order to use ocr in this script."; exit 1
  fi
  ($ec "launchGurp: ocr" &); grim -g "$(slurp -b 000000cc -c 005500cc)" - | tesseract stdin stdout | wl-copy
}

[ "$1" = "ocr" ] && ocr-screenshot || full-screenshot

