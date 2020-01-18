FROM registry.tikatuka.nl/tikatuka/debian-jessie-slim-armhf
LABEL AUTHOR="Mark de Bruijn <mrdebruijn@gmail.com>"

RUN export DEBIAN_FRONTEND=noninteractive && \
apt-get update && apt-get --no-install-recommends install -y curl python3-requests python3-paramiko \
libusb-dev libpython3.5-dev libcap2-bin libcurl3 libcurl3-gnutls &&  rm -rf /var/lib/apt/lists/*  && \
curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-armhf.tar.gz | tar -xzC /

WORKDIR /var/lib/domoticz

RUN curl -sSL https://releases.domoticz.com/releases/release/domoticz_linux_armv7l.tgz | tar -xzC . && \ 
curl -sSL https://releases.domoticz.com/releases/beta/domoticz_linux_armv7l.tgz | tar -xzC . && \ 
rm -rf www/js/domoticz.js.gz 

EXPOSE 8080
COPY root/ /
VOLUME [ "/config" ]
ENTRYPOINT [ "/init" ]
