#!/bin/sh

echo Install protxml2idlist

apt -y --no-install-recommends install libxml2-utils && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*