#!/usr/bin/sh

# First Check which player is running.
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
    # First check the status
    PLAYING="status playing"
    #PAUSED="status paused"

    STATUS=$(cmus-remote -Q | grep "status")

    if [ "$STATUS" == "$PAUSED" ];then
        echo ""
    else
        echo ""
    fi
elif [ $FLAG == 2 ];then
    PLAYING="[playing]"
    #PAUSED="[paused]"

    STATUS=$(mpc status | awk 'FNR>1 && FNR<=2')

    if [ "${STATUS[@]:0:9}" == "$PLAYING" ];then
        echo ""
    else
        echo ""
    fi
else
    echo ""
fi
