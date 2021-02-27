FROM debian:buster-slim

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common apache2 libapache2-mod-fcgid xvfb gnupg wget curl
RUN wget -qO - https://qgis.org/downloads/qgis-2020.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import && chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg
#RUN add-apt-repository "deb https://qgis.org/debian `lsb_release -c -s` main"
RUN echo "deb http://qgis.org/debian-ltr buster main" >> /etc/apt/sources.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key f7e06f06199ef2f2

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

