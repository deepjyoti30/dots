#!/bin/bash

# Uses cmus-remote to show song

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

if [ $FLAG == 1 ]; then
    # First method

    TITLE=$( cmus-remote -Q | grep title | cut -d " " -f 3- )
    # Sometimes this string turns out empty

    if [ -n "$TITLE" ];
    then
        echo ${TITLE[@]:0:20}
    else
        # Second method

        # Get the filename
        FILENAME=( $(cmus-remote -Q | grep -i "file") )
        # Remove file from the beginning
        FILENAME=${FILENAME[@]//"file"/""}
        # Remove the .mp3 too
        FILENAME=${FILENAME[@]//".mp3"/""}
        # Remove the dashes
        FILENAME=${FILENAME[@]//"_"/""}
        # Get just the basename
        SONG=$(basename "$FILENAME")
        echo "${SONG[@]:0:20}"
    fi
elif [ $FLAG == 2 ]; then
    # Try to get the title.

    TITLE=$(mpc -f %title% | awk 'FNR<=1')
    # In case the title string turns out empty then get the filename
    if [ -z "$TITLE" ];
    then
        #echo "nana"
        TITLE=$(mpc -f %file% | awk 'FNR<=1')
        TITLE=$( basename "$TITLE" )
        TITLE=${TITLE[@]//".mp3"/""}
        TITLE=${TITLE[@]//"_"/""}
        #echo $TITLE
    fi

    echo ${TITLE[@]:0:25}

else
    echo ""
fi
