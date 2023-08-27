#!/bin/sh


#apt -y update && apt -y upgrade && apt -y --no-install-recommends install libxml2-utils && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

echo "Installing protxml2idlist in conda environment"
conda update conda && conda create -n protxml2idlist -c anaconda libxml2