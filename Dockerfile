FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="Adam Beardwood"

ARG MONIT2TELEGRAM_URL=https://github.com/TheSpad/monit2telegram.git

RUN \
 echo "**** install packages ****" && \
 apk add --update --no-cache  \
            bash \
            curl \
            shadow \
            jq && \
 apk add --update --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ monit && \
 mkdir /config

# copy local files
COPY root/ /

EXPOSE 2812

VOLUME /config