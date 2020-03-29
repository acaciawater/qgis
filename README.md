QGIS Server
========================

A docker container that runs a QGIS Server version 3.10 (A Coruna)

This image is built upon debian:buster and installs qgis-server from http://qgis.org/debian-ltr buster main

Run the container:
```
docker run -d --rm --name qgs -p80:80 -v /home/theo/code/qgis/world:/project qgis
```


