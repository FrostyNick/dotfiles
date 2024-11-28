mkfifo /tmp/wobpipe # check if it exists first before runingg.... whyyyyy this
tail -f /tmp/wobpipe | wob &
