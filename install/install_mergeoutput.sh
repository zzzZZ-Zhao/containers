#!/bin/sh

echo "Installing mergeoutput in conda environment"

conda update conda && conda create -n mergeoutput -c conda-forge r-dplyr=1.0.9
