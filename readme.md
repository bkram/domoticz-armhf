# domoticz-armf

## Preface

Yet another Domoticz Dockerfile as no other images worked how I liked it.

Loosely based on two other Domoticz images for armhf:
- https://hub.docker.com/r/linuxserver/domoticz
- https://hub.docker.com/r/cgatay/domoticz

Tested on Cubox running Docker 19.03.5 on Armbian Debian Buster

## Build Dockerfile

```bash
docker build --rm -f "Dockerfile" -t tikatuka/domoticz-armhf:latest "."
```

## Create container

Uses a config directory in /home/domoticz/config, passes devices for P1 and Z-Wave.

```bash
docker create \
  --name=domoticz-armf \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/Amsterdam \
  -p 8080:8080 \
  -v /home/domoticz/config/:/config \
  --restart unless-stopped \
  --device /dev/ttyUSB0:/dev/ttyUSB0 \
  --device /dev/ttyUSB-ZStick-5G:/dev/ttyUSB-ZStick-5G \
  tikatuka/domoticz-armf:latest
```

## Start Container

```bash
docker container start domoticz-armhf
```

