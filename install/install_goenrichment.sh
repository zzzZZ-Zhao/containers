#!/bin/sh

echo Install GOEnrichment

mkdir -p /usr/share/man/man1 /usr/share/man/man2 &&  apt install -y --no-install-recommends openjdk-11-jre-headless && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir /usr/local/GOEnrichment && wget -O /usr/local/GOEnrichment/GOEnrichment.jar https://github.com/DanFaria/GOEnrichment/releases/download/v2.0.1/GOEnrichment.jar
