#!/usr/bin/sh

t=0

toggle() {
    t=$(((t + 1) % 2))
}


trap "toggle" USR1

while true; do
    if [ $t -eq 0 ]; then
        date
    else
        date --rfc-3339=seconds
    fi
    sleep 1 &
    wait
done
