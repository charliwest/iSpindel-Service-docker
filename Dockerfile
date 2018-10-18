FROM resin/raspberrypi3-python:2.7
MAINTAINER charliwest

# expose port 9501 for iSpindel
EXPOSE 9501

# install apt dependencies
#RUN apt-get update && apt-get install -y \
#  build-essential \
#  python-dev \
#  python-pip \
#  git \
#  vim \
#  dfu-util \
#  sudo

# upgrade pip
RUN pip install --upgrade pip

# install setuptools and wheel
RUN pip install --upgrade setuptools wheel

# install pip dependencies
RUN pip install --upgrade pyserial psutil simplejson configobj gitpython

# clone iSpindel-TCP-Server repositories
RUN git clone https://github.com/DottoreTozzi/iSpindel-TCP-Server.git /root/ispindel

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy script that periodically checks the script status
COPY watcher.sh /watcher.sh
RUN chmod +x /watcher.sh

WORKDIR /root/ispindel/

# this will always run
ENTRYPOINT ["/entrypoint.sh"]

# this will be run after entrypoint, unless overridden by the user
CMD ["/watcher.sh"]
