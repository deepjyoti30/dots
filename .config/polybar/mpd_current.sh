#!/usr/bin/sh

# Get the current playing song using mpc
CURRENT_SONG=`mpc --host 127.0.0.1 --port 6601 | cut -d$'\n' -f1`
WORDS_TO_EXCLUDE=("random" "repeat" "consume" "single")

for WORD in "${WORDS_TO_EXCLUDE[@]}"
do
    if [[ "$CURRENT_SONG" == *"$WORD"* ]]; then
        echo "No song is playing" | tr '[:lower:]' '[:upper:]'
        exit 0
    fi
done

# Check if the song name is long, in which case truncate it.

if [ ${#CURRENT_SONG} -ge 40 ]; then
    echo "${CURRENT_SONG:0:40}.."
else
    echo $CURRENT_SONG
fi