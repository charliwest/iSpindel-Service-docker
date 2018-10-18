#!/bin/sh

# Make sure to always have the log files around
touch /var/log/stderr.txt
chmod 755 /var/log/stderr.txt
touch /var/log/stdout.txt
chmod 755 /var/log/stderr.txt
mkdir -p /config/csv
chmod 755 /config/csv

# run command if passed to the container, instead of running watcher.sh
exec "$@"
