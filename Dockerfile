FROM debian:buster-slim

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends apache2 libapache2-mod-fcgid xvfb gnupg curl
RUN echo "deb http://qgis.org/debian-ltr buster main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 51F523511C7028C3
RUN apt-get update && apt-get install -y --no-install-recommends qgis-server python-qgis

ENV APACHE_CONFDIR /etc/apache2
ENV APACHE_ENVVARS $APACHE_CONFDIR/envvars
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE $APACHE_RUN_DIR/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C

WORKDIR /qgis
ADD init start *.conf /qgis/
RUN ./init
EXPOSE 80
CMD ./start
