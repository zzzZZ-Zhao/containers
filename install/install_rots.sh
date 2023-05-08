#!/bin/sh

echo "Installing rots in conda environment"

conda create -n rots  -c bioconda -c conda-forge -c defaults bioconductor-rots=1.22.0