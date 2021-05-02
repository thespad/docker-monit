FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="Adam Beardwood"
LABEL org.opencontainers.image.source=https://github.com/TheSpad/docker-monit

RUN \
  echo "**** install packages ****" && \
  apk add --update --no-cache --virtual=build-dependencies \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev && \
  apk add -U --upgrade --no-cache  \
    bash \
    curl \
    python3 \
    py3-pip && \
  apk add -U --upgrade --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ monit && \
  mkdir -p /tmp/wheels && \
  curl -s -o \
    /tmp/cryptography.tar.gz -L \
    "https://github.com/TheSpad/docker-monit/raw/main/wheels/cryptography.tar.gz" && \
  tar xf \
    /tmp/cryptography.tar.gz -C \
    /tmp/wheels/ --strip-components=1 && \
  pip install --no-cache-dir --upgrade \
    wheel && \
  pip install --no-cache-dir --upgrade --find-links=/tmp/wheels apprise && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    /root/.cache

COPY root/ /

EXPOSE 2812

VOLUME /config