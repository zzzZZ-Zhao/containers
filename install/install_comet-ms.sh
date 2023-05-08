#!/bin/sh

echo "Installing comet-ms in conda environment"

conda create -n comet-ms  -c bioconda -c conda-forge -c defaults comet-ms=2021010=h87f3376_1