QGIS Server
========================

A docker container that runs QGIS Server version 3.10 LTR (A Coruna)

This image is built upon debian:buster and installs qgis-server from http://qgis.org/debian-ltr buster main

Run the container:
```
docker run -d --rm -p 80:80 -v /path/to/your/projects:/project qgis:ltr
```


