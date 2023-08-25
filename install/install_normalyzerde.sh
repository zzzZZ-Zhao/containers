#!/bin/sh

echo "Installing normalyzerde in conda environment"
conda update conda && conda create -n bioconductor-normalyzerde  -c bioconda -c conda-forge -c defaults bioconductor-normalyzerde=1.16.0
