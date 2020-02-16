FROM --platform=linux/arm/v7 debian:buster-slim
LABEL AUTHOR="Mark de Bruijn <mrdebruijn@gmail.com>"
LABEL description="Domoticz Beta Docker Image with python support"

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && \
apt-get install --no-install-recommends -y  apt-utils && apt install -y libusb-0.1-4 libcap2-bin libcurl3-gnutls curl libcurl4 \
python3-requests python3-paramiko libpython3.7-dev && rm -rf /var/lib/apt/lists/* && c_rehash

RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-armhf.tar.gz | tar -xzC /

WORKDIR /var/lib/domoticz
RUN curl -sSL https://releases.domoticz.com/releases/beta/domoticz_linux_armv7l.tgz | tar -xzCv .

EXPOSE 8080 8443
COPY root/ /

VOLUME [ "/config" ]
ENTRYPOINT [ "/init" ]
