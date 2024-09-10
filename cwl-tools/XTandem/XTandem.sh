#!/bin/bash
set -e

mkdir /tmp/XTandem && \
wget -O /tmp/XTandem/tandem.params https://raw.githubusercontent.com/Workflomics/containers/main/cwl/tools/XTandem/tandem.params &&  \
wget -O /tmp/XTandem/taxonomy.xml https://raw.githubusercontent.com/Workflomics/containers/main/cwl/tools/XTandem/taxonomy.xml && \
cp /data/inputs/up00000062.fasta /tmp/XTandem/fastaFile.fasta && \
cp /data/inputs/2021-10-8_Ecoli.mzML /tmp/XTandem/mzmlFile.mzML && \
/usr/local/tpp/bin/tandem /tmp/XTandem/tandem.params && \
/usr/local/tpp/bin/Tandem2XML /tmp/XTandem/tandemFile.tandem > output.pep.xml