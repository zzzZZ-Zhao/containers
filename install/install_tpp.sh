#!/bin/sh

echo "Installing TPP 6.3"

INSTALL_DIR=/usr/local

apt -y update && apt -y upgrade && apt install -y --no-install-recommends g++ perl libcgi-pm-perl libio-compress-perl libgd-dev libpng-dev zlib1g-dev libbz2-dev gnuplot unzip libexpat1 libexpat1-dev apache2 xsltproc nano vim && apt-get clean && \
        apt-get purge && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# export PERL_MM_USE_DEFAULT=1 && cpan install CGI XML::Parser FindBin::libs JSON 

wget -O TPP_6.3.2-src.tgz https://sourceforge.net/projects/sashimi/files/Trans-Proteomic%20Pipeline%20%28TPP%29/TPP%20v6.3%20%28Arcus%29%20rev%202/TPP_6.3.2-src.tgz/download
tar -xf TPP_6.3.2-src.tgz
cd release_6-3-2
make all
make install

cd ~
rm -rf release_6-3-2 TPP_6.3.2-src.tgz

# set environment variables
echo PERL5LIB="${INSTALL_DIR}/tpp/lib/perl" >>/etc/environment
