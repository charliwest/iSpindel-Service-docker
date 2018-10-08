#!/bin/sh

# check if persisted data already exists
if [ "$(ls -A /logs)" ]; then
  # if files already exist, remove the defaults.
  # We'll replace them with symlinks to persisted data
  echo "Persistent files already present"
  rm -rf /home/ispindle/logs
  rm -rf /var/www/html/data
else
  echo "Setting up new persisted data directory outside of container"
  # if files don't exist, copy them to the persisted location outside the container
  mv /home/ispindle/logs /data/logs
  mv /var/www/html/data /data/html_data
fi

# create symlinks to persisted data outside of container
ln -s -b /data/logs /home/ispindle/logs
ln -s -b /data/html_data /var/www/html/data

# Make sure to always have the log files around
mkdir -p /home/ispindle/logs
touch /home/ispindle/logs/stderr.txt
chmod 755 /home/ispindle/logs/stderr.txt
touch /home/ispindle/logs/stdout.txt
chmod 755 /home/ispindle/logs/stderr.txt

# setup default password for port 81 if the password file doesn't exist
if ! [ -f /data/settings/ispindle.htpasswd ]; then
  htpasswd -bc /data/settings/ispindle.htpasswd ohyeah ispindle
fi

service nginx start
service php7.0-fpm start

# run command if passed to the container, instead of running watcher.sh
exec "$@"
