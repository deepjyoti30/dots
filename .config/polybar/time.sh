#!/bin/sh

# So this script will make the clock work in 12-hour format
HOUR=$(date +%H)
MIN=$(date +%M)
ELEVEN=11
TWELVE=12
ICON=

if [ $HOUR -gt $ELEVEN ];then
    if [ $HOUR -eq $TWELVE ];
    then
        NEW_HOUR=$HOUR
    else
        NEW_HOUR=$(($HOUR-$TWELVE))
    fi
    echo "$NEW_HOUR:$MIN P.M."
else
    echo "$HOUR:$MIN A.M."
fi
