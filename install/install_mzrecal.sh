#!/bin/sh



echo "Installing mzrecal"

mkdir go && cd go && wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz  && \
 tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz && export PATH=$PATH:/usr/local/go/bin  && \
 cd ~ && git clone https://github.com/524D/mzrecal && cd mzrecal && ./build.sh  && \ 
 mkdir /usr/local/mzrecal && cp -r ~/tools/* /usr/local/mzrecal  && \
 rm -rf /usr/local/go ~/go ~/mzrecal ~/tools