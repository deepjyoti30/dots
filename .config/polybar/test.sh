#!/bin/bash

chars=$(cmus-remote -Q | grep -i "file")

while :; do
  for (( i=0; i<${#chars}; i++ )); do
    sleep 0.5
    echo -en "${chars:$i:25}" "\r"
  done
done
