#!/bin/sh

# check if persisted data already exists
if [ "$(ls -A /logs)" ]; then
  # if files already exist, remove the defaults.
  # We'll replace them with symlinks to persisted data
  echo "Persistent files already present"
  rm -rf /root/ispindle/logs

else
  echo "Setting up new persisted data directory outside of container"
  # if files don't exist, copy them to the persisted location outside the container
  mv /root/ispindle/logs /data/logs
fi
V
# create symlinks to persisted data outside of container
ln -s -b /data/logs /root/ispindle/logs

# Make sure to always have the log files around
mkdir -p /root/ispindle/logs
touch /root/ispindle/logs/stderr.txt
chmod 755 /root/ispindle/logs/stderr.txt
touch /root/ispindle/logs/stdout.txt
chmod 755 /root/ispindle/logs/stderr.txt
mkdir -p /root/ispindle/csv
chmod 755 /root/ispindle/csv

# run command if passed to the container, instead of running watcher.sh
exec "$@"
