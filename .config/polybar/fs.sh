#!/usr/bin/sh

ICON=

DATA=($(df -hT /home))
PERCENT=${DATA[@]:13:14}

# Remove space and the /

SPACE_REMOVED=${PERCENT[@]//' '/''}
DASH_REMOVED=${PERCENT[@]//'/'/''}
OUTPUT=$DASH_REMOVED

echo "$ICON $OUTPUT"
