FROM ghcr.io/linuxserver/baseimage-alpine:3.14

LABEL maintainer="Adam Beardwood"
LABEL org.opencontainers.image.source=https://github.com/TheSpad/docker-monit

RUN \
  echo "**** install packages ****" && \
  apk add --update --no-cache --virtual=build-dependencies \
    gcc \
    musl-dev \
    python3-dev \
    py3-wheel \
    libffi-dev \
    openssl-dev \
    cargo && \
  apk add -U --upgrade --no-cache  \
    bash \
    curl \
    python3 \
    py3-pip && \
  echo "**** install monit ****" && \
  if [ -z ${APP_VERSION+x} ]; then \    
    APP_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.14/main/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
    && awk '/^P:'"monit"'$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  apk add -U --upgrade --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ monit && \
  pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine/ apprise && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    /root/.cargo \
    /root/.cache

COPY root/ /

EXPOSE 2812

VOLUME /config