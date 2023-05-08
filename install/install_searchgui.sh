#!/bin/sh

echo "Installing searchgui in conda environment"
conda create -n searchgui  -c bioconda -c conda-forge -c defaults searchgui=4.0.41

