FROM registry.tikatuka.nl/tikatuka/debian-buster-slim-armhf
LABEL AUTHOR="Mark de Bruijn <mrdebruijn@gmail.com>"
LABEL description="Domoticz beta Docker image"

RUN export DEBIAN_FRONTEND=noninteractive && \
apt-get update && apt-get --no-install-recommends install -y python3-requests python3-paramiko python3-certifi \
libusb-dev libpython3.7-dev libcap2-bin wget libcurl3-gnutls libcurl4 && rm -rf /var/lib/apt/lists/*  && \
wget -O - https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-armhf.tar.gz | tar -xzC /

WORKDIR /var/lib/domoticz
RUN wget -O - https://releases.domoticz.com/releases/release/domoticz_linux_armv7l.tgz | tar -xzC . && \ 
wget -O - https://releases.domoticz.com/releases/beta/domoticz_linux_armv7l.tgz | tar -xzC . && \ 
rm -rf www/js/domoticz.js.gz 

EXPOSE 8080 8443
COPY root/ /
VOLUME [ "/config" ]
ENTRYPOINT [ "/init" ]
