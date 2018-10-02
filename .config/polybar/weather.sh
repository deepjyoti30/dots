#!/bin/sh

get_icon() {
  case $1 in
    01d) icon="";;
    01n) icon="";;
    02d) icon="";;
    02n) icon="";;
    03*) icon="";;
    04*) icon="";;
    09d) icon="";;
    09n) icon="";;
    10d) icon="";;
    10n) icon="";;
    11d) icon="";;
    11n) icon="";;
    13d) icon="";;
    13n) icon="";;
    50d) icon="";;
    50n) icon="";;
    *) icon="";
  esac

  echo $icon
}

# API key from openweathermap. Add yours by signing up there.
API_KEY="fd2c04ed7f9802656bd2cc23bddc7ad9"
# Get your lat and long. Just Google.
LAT="26.111898"
LON="91.797896"
UNITS="metric"
SYMBOL="°C"

weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LON&units=$UNITS&APPID=$API_KEY")

if [ ! -z "$weather" ]; then
  #description=$(echo "$weather" | jq -r ".weather[0].description")
  temperature=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
  icon=$(echo "$weather" | jq -r ".weather[0].icon")

  echo "$(get_icon "$icon")" "$temperature$SYMBOL"
fi
