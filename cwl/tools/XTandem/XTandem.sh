#!/bin/bash
set -e

wget -O /cwl/tools/XTandem/tandem.params https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/XTandem/tandem.params &&  \
wget -O /cwl/tools/XTandem/taxonomy.xml https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/XTandem/taxonomy.xml && \
cp /data/inputs/up00000062.fasta /cwl/tools/XTandem/fastaFile.fasta && \
cp /data/inputs/2021-10-8_Ecoli.mzML /cwl/tools/XTandem/mzmlFile.mzML && \
/usr/local/tpp/bin/tandem /cwl/tools/XTandem/tandem.params && \
/usr/local/tpp/bin/Tandem2XML /cwl/tools/XTandem/tandemFile.tandem /data/tandemPepXml.tandem.pep.xml