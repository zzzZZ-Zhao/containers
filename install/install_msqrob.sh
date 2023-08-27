#!/bin/sh

echo "Installing msqrob in conda environment"

conda update conda && conda create -n msqrob  -c bioconda -c conda-forge -c defaults r-msqrob=0.7.7

