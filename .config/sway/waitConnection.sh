#!/usr/bin/env bash

# attempts=0
while [ -z "$(echo $(nmcli g) | grep 'connected full')" ] ; do
    echo 'waiting for connection...'
    sleep 5;
done
echo 'connected!'

# return 0; # ok
# return -1; # timeout
