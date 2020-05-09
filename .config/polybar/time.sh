#!/bin/sh

# So this script will make the clock work in 12-hour format

TIME="$( date +"%I:%M %p" )"
# DAY="$( date +"%d %B" | cut -c 1-6 )"
echo $TIME
