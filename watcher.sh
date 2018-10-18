#!/bin/sh

while true
do
  if ! python /root/ispindle/iSpindle.py --checkstartuponly --dontrunfile
    then python -u /root/ispindle/iSpindle.py 1>/root/ispindle/logs/stdout.txt 2>>/root/ispindle/logs/stderr.txt
  fi
  sleep 10
done
