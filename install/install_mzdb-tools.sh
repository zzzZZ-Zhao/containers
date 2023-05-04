#!/bin/sh

INSTALL_DIR=/usr/local

mkdir $INSTALL_DIR/mzdb-tools ; cd $INSTALL_DIR/mzdb-tools; 
wget https://github.com/mzdb/mzdb4s/releases/download/0.4.3/mzdbtools_0.4.3_linux_x64.zip; 
unzip mzdbtools_0.4.3_linux_x64.zip; cd ..; 
chmod a+x $INSTALL_DIR/mzdb-tools/run_thermo2mzdb.sh; chmod a+x $INSTALL_DIR/mzdb-tools/thermo2mzdb; ln -s $INSTALL_DIR/mzdb-tools/run_thermo2mzdb.sh /usr/bin/thermo2mzdb; 
chmod a+x $INSTALL_DIR/mzdb-tools/mzdbtools; 
chmod a+x $INSTALL_DIR/mzdb-tools/run_mzdb2mgf.sh; chmod a+x $INSTALL_DIR/mzdb-tools/mzdb2mgf; ln -s $INSTALL_DIR/mzdb-tools/run_mzdb2mgf.sh /usr/bin/mzdb2mgf