FROM lsiobase/alpine.python.armhf:3.8
MAINTAINER charliwest

# expose port 9501 for iSpindel
EXPOSE 9501

# upgrade pip
RUN pip install --upgrade pip

# install setuptools and wheel
RUN pip install --upgrade setuptools wheel

# install pip dependencies
RUN pip install --upgrade pyserial psutil simplejson configobj gitpython

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy script that periodically checks the script status
COPY watcher.sh /watcher.sh
RUN chmod +x /watcher.sh

WORKDIR /root/ispindle/

# this will always run
ENTRYPOINT ["/entrypoint.sh"]

# this will be run after entrypoint, unless overridden by the user
CMD ["/watcher.sh"]
