#!/bin/bash
neededpips="jellyfin-mpv-shim streamlink pulsemixer"
echo "$neededpips" | sed 's| |~|g' | tr '~' '\n' | sort | uniq | \
while IFS= read -r i; do
    if [ ! "$(pip list | grep -q "^$i " && echo 1)" == "1" ]; then
        pip install "$i"
    fi
done
