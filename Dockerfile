FROM schachr/raspbian-stretch:latest
LABEL AUTHOR="Bkram <mrdebruijn@gmail.com>"

RUN apt-get update && apt-get upgrade && \
    apt-get install -y net-tools netcat apt-utils whiptail git curl unzip wget sudo cron \
    libudev-dev python3-requests python3-paramiko libusb-dev libpython3.5-dev libcap2-bin && \
    curl -SL https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-armhf.tar.gz | tar -xzC / && \
    useradd domoticz -M -d /var/lib/domoticz -u 1001 && usermod -a -G dialout domoticz

COPY root/ /

WORKDIR /var/lib/domoticz

RUN curl -L install.domoticz.com -o install_domoticz.sh && \
    cat install_domoticz.sh | grep -P '\tmakeStartupScript' -v | grep -P '\tstart_service' -v | \
    grep -P '\tenable_service' -v > install_domoticz_without_startup_scripts.sh && \
    bash ./install_domoticz_without_startup_scripts.sh --unattended && \
    cat updatebeta | grep 'sudo service domoticz.sh restart' -v > updatebetawithoutservice && \
    chmod a+x updatebetawithoutservice && ./updatebetawithoutservice && \
    rm -rf www/js/domoticz.js.gz install_domoticz*.sh server_cert.pem update*

ENTRYPOINT ["/init"]
VOLUME /config
