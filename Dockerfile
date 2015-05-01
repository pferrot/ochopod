FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

#
# - update our repo
# - add python 2.7 + some utilities
#
RUN apt-get -y upgrade
RUN apt-get -y update
RUN apt-get -y install curl python python-requests supervisor

#
# - add the ochopod package and install it
# - remove defunct packages
# - start supervisor
#
ADD resources/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD sdk/ochopod /opt/ochopod
RUN cd /opt/ochopod && python setup.py install
RUN apt-get -y autoremove
CMD /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf