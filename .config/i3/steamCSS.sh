#!/bin/bash
# Credit: https://steamcommunity.com/sharedfiles/filedetails/?id=2921972296
# not sure if useful for later: https://developer.valvesoftware.com/wiki/Steam_Skins
#
# will use this to add text to remind myself a fix that I need to add everytime.
STEAM_DIR=$HOME/.local/share/Steam
SUI_INDX=$STEAM_DIR/steamui/index.html
if ( ! grep -q webkit\.css $SUI_INDX ); then
	sed -i 's/<\/head>/\<link href="webkit.css" rel="stylesheet"><\/head>/' $SUI_INDX
	echo "steamui/index.html edited"
fi

# For the final part, copy the contents of /usr/bin/steam
# and add -noverifyfiles
exec /usr/lib/steam/steam -noverifyfiles "$@"
