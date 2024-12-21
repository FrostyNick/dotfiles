mkfifo /tmp/wobpipe # check if it exists first before runingg.... whyyyyy this
killall wob
tail -f /tmp/wobpipe | wob &
disown
