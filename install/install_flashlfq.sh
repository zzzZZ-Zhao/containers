#!/bin/sh

echo "Installing flashlfq in conda environment"

conda create -n flashlfq -c bioconda -c conda-forge -c defaults flashlfq=1.1.1
