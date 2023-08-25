#!/bin/sh

echo "Installing protxml2csv in conda environment"
conda update conda && conda create -n protxml2csv -c conda-forge   r-progress=1.2.2  r-xml=3.99-0.10 r-stringi=1.7.6