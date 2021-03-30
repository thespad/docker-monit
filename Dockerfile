FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="Adam Beardwood"

RUN \
 echo "**** install packages ****" && \
 apk add --update --no-cache  \
            bash \
            curl \
            shadow \
            jq && \
 apk add --update --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ monit

# copy local files
COPY root/ /

EXPOSE 2812

VOLUME /config