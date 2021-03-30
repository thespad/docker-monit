FROM ghcr.io/linuxserver/baseimage-alpine:3.13

LABEL maintainer="Adam Beardwood"

ARG MONIT2TELEGRAM_URL=https://github.com/TheSpad/monit2telegram.git

RUN \
 echo "**** install packages ****" && \
 apk add --update --no-cache  \
            git \
            bash \
            curl \
            shadow \
            jq && \
 apk add --update --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ monit
 mkdir -p /opt/src; cd /opt/src && \
 echo "*** install monit2telegram ***" && \
 mkdir -p /opt/src/git; cd /opt/src/git && \
 git clone ${MONIT2TELEGRAM_URL} && \
 cd monit2telegram && \
 cp sendtelegram.sh /usr/local/bin/sendtelegram && \
 chmod +x /usr/local/bin/sendtelegram && \
 cp monit2telegram.sh /usr/local/bin/monit2telegram && \
 chmod +x /usr/local/bin/monit2telegram && \
 rm -rf /opt/src

# copy local files
COPY root/ /

EXPOSE 2812
