#!/usr/bin/sh

# First Check if which player is running.
FLAG=0

APPS=("cmus mpd mopidy")

for APP in $APPS
do
    pat="([^\w-]$APP)"
    if ps ux | grep -P $pat | grep -vq grep; then
        if [ $APP == "cmus" ]; then
            FLAG=1
        elif [ $APP == "mpd" ] || [ $APP == "mopidy" ]; then
            FLAG=2
        fi
    fi
done

if [ $FLAG == 1 ];then
    cmus-remote -r
elif [ $FLAG == 2 ];then
    mpc prev
fi
