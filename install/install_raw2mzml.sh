#!/bin/sh

echo "Installing raw2mzml in conda environment"

conda create -n raw2mzml  -c bioconda -c conda-forge -c defaults thermorawfileparser=1.4.0=ha8f3691_0