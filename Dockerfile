FROM ubuntu:14.04
MAINTAINER Santiago Lezica

# Install Spotify and PulseAudio.
WORKDIR /usr/src

# Install APT keys and necessary packages:
RUN apt-key adv \
  --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

RUN echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list

RUN apt-get update && apt-get install -y \
		spotify-client \
    xdg-utils \
    libxss1 \
		pulseaudio \
		ttf-wqy-zenhei

RUN apt-get clean

# Disable use of shared memory for PulseAudio:
RUN echo enable-shm=no >> /etc/pulse/client.conf

# Configure external volumes:
VOLUME ["/data/cache", "/data/config", "/data/music"]
RUN mkdir -p /data/cache /data/config /data/music

# Make PulseAudio available:
ENV PULSE_SERVER /run/pulse/native

COPY entry.sh /entry.sh
ENTRYPOINT ["/entry.sh"]
