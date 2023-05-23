#!/bin/sh

# conda create -n tpp  -c bioconda -c conda-forge -c defaults tpp=5.0.0=pl5.22.0_0

# install TPP 5.2
# copied from TPP docker file

echo "Installing TPP 5.2"

INSTALL_DIR=/usr/local

apt -y update && apt -y upgrade && apt install -y --no-install-recommends gnuplot unzip libexpat1 libexpat1-dev apache2 xsltproc nano vim && apt-get clean && \
        apt-get purge && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

export PERL_MM_USE_DEFAULT=1 && cpan install CGI XML::Parser FindBin::libs JSON 


cd $INSTALL_DIR && wget "http://www.tppms.org/sw/TPP5.2/TPP5.2_ubuntu.tgz" && tar xvfz TPP5.2_ubuntu.tgz && chmod -R a+rwx tpp && rm -f TPP5.2_ubuntu.tgz

cd $INSTALL_DIR/tpp/conf &&  a2enmod rewrite && a2enmod cgid && cat httpd-2.4-tpp.conf | sed 's/#Require all granted/Require all granted/' > httpd-2.4-tpp-1.conf && perl -pi -e 's/_TPP_PORT_/10401/g' httpd-2.4-tpp-1.conf && cp -p $INSTALL_DIR/tpp/conf/httpd-2.4-tpp-1.conf /etc/apache2/conf-available/httpd-tpp.conf && ln -s /etc/apache2/conf-available/httpd-tpp.conf /etc/apache2/conf-enabled/httpd-tpp.conf && perl -pi -e 's/www-data/biodocker/g' /etc/apache2/envvars


#conda create -n tpp  -c bioconda -c conda-forge -c defaults 

# set environment variables
echo PERL5LIB="${INSTALL_DIR}/tpp/lib/perl" >>/etc/environment
sed -i '/PATH/s/"$/:${INSTALL_DIR}\/tpp\/bin\/:\/usr\/local\/tpp\/cgi-bin"/' /etc/environment
#echo PATH="/opt/conda/envs/wombatp-tpp/bin:${PATH}" >>/etc/environment
