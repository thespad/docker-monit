FROM alpine:latest

LABEL maintainer="Adam Beardwood"

# monit environment variables
ARG MONIT2TELEGRAM_URL=https://github.com/TheSpad/monit2telegram.git

# Compile and install monit + monit2telegram
RUN \
    echo "*** install monit and dependencies ***" && \
    apk add --update --no-cache monit git bash curl shadow && \
    mkdir -p /opt/src; cd /opt/src && \
    echo "*** install monit2telegram ***" && \
    mkdir -p /opt/src/git; cd /opt/src/git && \
    git clone ${MONIT2TELEGRAM_URL} && \
    cd monit2telegram && \
    cp sendtelegram.sh /usr/local/bin/sendtelegram && \
    chmod +x /usr/local/bin/sendtelegram && \
    cp monit2telegram.sh /usr/local/bin/monit2telegram && \
    chmod +x /usr/local/bin/monit2telegram && \
    apk del gcc musl-dev make libressl-dev file zlib-dev && \
    rm -rf /opt/src

RUN \
    echo "**** create abc user and make our folders ****" && \
    groupmod -g 1000 users && \
    useradd -u 1000 -U -d /config -s /bin/false abc && \
    usermod -G users abc && \
    mkdir /config && \
    chown abc:abc /config

EXPOSE 2812

CMD ["monit", "-I", "-B"]
