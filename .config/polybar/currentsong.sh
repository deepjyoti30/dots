#!/bin/sh

# Uses pulse audio to get the current song name
ARR=($(pacmd list-sink-inputs | grep -i "media.title"))

# Get the state
STATE=$(pacmd list-sink-inputs | grep -i "state")

# Declare the req variables
RUNNING="	state: RUNNING"
STOPPED="	state: CORKED"

# Remove the "
OUT=${ARR[@]//'"'/''}

# Remove the media.title
SONG=${OUT[@]:14: 35}

# Check state and display accordingly
if [ "$STATE" == "$RUNNING" ];then
    echo " $SONG"
elif [ "$STATE" == "$STOPPED" ];then
    echo " $SONG"
else
    echo ""
fi