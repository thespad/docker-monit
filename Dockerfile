FROM alpine:3.8

LABEL maintainer="Adam Beardwood"

# monit environment variables
ENV MONIT_VERSION=5.26.0 \
    MONIT_HOME=/opt/monit \
    MONIT_URL=https://mmonit.com/monit/dist \
    PATH=$PATH:/opt/monit/bin \
    MONIT2TELEGRAM_URL=https://github.com/matriphe/monit2telegram.git

# Compile and install monit + monit2telegram
RUN \
    echo "*** compile and install monit ***" && \
    apk add --update gcc musl-dev make libressl-dev file zlib-dev git bash curl && \
    mkdir -p /opt/src; cd /opt/src && \
    wget -qO- ${MONIT_URL}/monit-${MONIT_VERSION}.tar.gz | tar xz && \
    cd /opt/src/monit-${MONIT_VERSION} && \
    ./configure --prefix=${MONIT_HOME} --without-pam && \
    make && make install && \
    echo "*** install monit2telegram ***" && \
    mkdir -p /opt/src/git; cd /opt/src/git && \
    git clone ${MONIT2TELEGRAM_URL} && \
    cd monit2telegram && \
    cp sendtelegram.sh /usr/local/bin/sendtelegram && \
    chmod +x /usr/local/bin/sendtelegram && \
    cp monit2telegram.sh /usr/local/bin/monit2telegram && \
    chmod +x /usr/local/bin/monit2telegram && \
    apk del gcc musl-dev make libressl-dev file zlib-dev && \
    rm -rf /var/cache/apk/* /opt/src

EXPOSE 2812

CMD ["monit", "-I", "-B"]
