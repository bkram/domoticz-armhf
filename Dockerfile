FROM registry.tikatuka.nl/tikatuka/debian-buster-slim-armhf
LABEL AUTHOR="Mark de Bruijn <mrdebruijn@gmail.com>"
LABEL description="Domoticz beta Docker image"

RUN export DEBIAN_FRONTEND=noninteractive && \
apt-get update && apt-get --no-install-recommends install -y curl python3-requests python3-paramiko \
libusb-dev libpython3.7-dev libcap2-bin libcurl4 &&  rm -rf /var/lib/apt/lists/*  && \
curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-armhf.tar.gz | tar -xzC /

WORKDIR /var/lib/domoticz
RUN curl -sSL https://releases.domoticz.com/releases/release/domoticz_linux_armv7l.tgz | tar -xzC . && \ 
curl -sSL https://releases.domoticz.com/releases/beta/domoticz_linux_armv7l.tgz | tar -xzC . && \ 
rm -rf www/js/domoticz.js.gz 

EXPOSE 8080 8443
COPY root/ /
VOLUME [ "/config" ]
ENTRYPOINT [ "/init" ]
