#!/bin/sh

echo "Installing peptideshaker in conda environment"

conda create -n peptideshaker  -c bioconda -c conda-forge -c defaults peptide-shaker=2.2.6