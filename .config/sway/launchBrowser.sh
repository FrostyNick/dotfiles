#!/usr/bin/env bash
menu=$1
[ -z $1 ] && menu=dmenu

pf=$(ls ~/.librewolf/*.*/ -d --hyperlink=no | $menu)
# ls -lh $pf # debugging

[ $pf ] && (librewolf --profile $pf &) || echo Canceled launching.
