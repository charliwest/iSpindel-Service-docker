#!/bin/sh

while true
do
  if ! python /home/ispindle/iSpindle.py --checkstartuponly --dontrunfile
    then python -u /home/ispindle/iSpindle.py 1>/home/ispindle/logs/stdout.txt 2>>/home/ispindle/logs/stderr.txt
  fi
  sleep 10
done
