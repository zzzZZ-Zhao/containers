
#!/bin/sh

echo "Installing maxquant in conda environment"

conda create -n maxquant -c bioconda -c conda-forge -c defaults maxquant=2.0.3.0=py310hdfd78af_1
