FROM --platform=linux/arm/v7 debian:buster
LABEL AUTHOR="Mark de Bruijn <mrdebruijn@gmail.com>"
LABEL description="Domoticz Beat Docker Image"

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && \
apt-get install -y  apt-utils && apt install -y libusb-dev libcap2-bin libcurl3-gnutls curl libcurl4 && \
rm -rf /var/lib/apt/lists/* && c_rehash
RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-armhf.tar.gz | tar -xzC /

WORKDIR /var/lib/domoticz
RUN curl -sSL https://releases.domoticz.com/releases/beta/domoticz_linux_armv7l.tgz | tar -xzC .

EXPOSE 8080 8443
COPY root/ /
VOLUME [ "/config" ]
ENTRYPOINT [ "/init" ]