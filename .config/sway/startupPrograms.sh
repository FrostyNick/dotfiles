#!/usr/bin/env bash

cd "$HOME/.config/sway/"
./waitConnection.sh
(vesktop || vencorddesktop || notify-send 'could not start vesktop') & disown
# betterbird & disown


