#!/bin/sh

while true
do
  if ! python /config/iSpindle.py --checkstartuponly --dontrunfile
    then python -u /config/iSpindle.py 1>/var/log/stdout.txt 2>>/var/log/stderr.txt
  fi
  sleep 10
done
