echo $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%') > /tmp/wobpipe
