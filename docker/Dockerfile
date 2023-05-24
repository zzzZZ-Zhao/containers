# Base image
FROM workflomics/base:v1.0

################## METADATA ######################

LABEL base_image="workflomics/base:v1.0"
LABEL version="1.0"
LABEL software="Workflomics"
LABEL about.summary="Workflomics image with following tools installed:  "
LABEL about.home=""
LABEL about.documentation=""
LABEL about.license_file=""
LABEL about.license="SPDX:Apache-2.0"
LABEL about.tags="Genomics,Proteomics,Transcriptomics,General,Metabolomics"

################## Author ######################
LABEL author="Nauman Ahmed"


#Install cwl-runner and the required tools
# RUN pip install cwlref-runner \
# && conda create -n comet-ms  -c bioconda -c conda-forge -c defaults comet-ms=2021010=h87f3376_1 \
# && conda create -n flashlfq -c bioconda -c conda-forge -c defaults flashlfq=1.1.1 \
# && conda create -n maxquant -c bioconda -c conda-forge -c defaults maxquant=2.0.3.0=py310hdfd78af_1 \
# && conda create -n mergeoutput -c conda-forge  r-dplyr=1.0.9 \
# && conda create -n msqrob  -c bioconda -c conda-forge -c defaults r-msqrob=0.7.7 \
# && conda create -n bioconductor-normalyzerde  -c bioconda -c conda-forge -c defaults bioconductor-normalyzerde=1.16.0 \
# && conda create -n peptideshaker  -c bioconda -c conda-forge -c defaults peptide-shaker=2.2.6 \
# && conda create -n polystest  -c bioconda -c conda-forge -c defaults polystest=1.2.2 \
# && conda create -n protxml2csv -c conda-forge   r-progress=1.2.2  r-xml=3.99-0.10 r-stringi=1.7.6 \
# && conda create -n raw2mzml  -c bioconda -c conda-forge -c defaults thermorawfileparser=1.4.0=ha8f3691_0 \
# && conda create -n rots  -c bioconda -c conda-forge -c defaults bioconductor-rots=1.22.0 \
# && conda create -n sdrf-pipelines  -c bioconda -c conda-forge -c defaults sdrf-pipelines=0.0.21=1.22.0 \
# && conda create -n searchgui  -c bioconda -c conda-forge -c defaults searchgui=4.0.41 \
# && conda create -n tpp  -c bioconda -c conda-forge -c defaults tpp=5.0.0=pl5.22.0_0 

# Copy the install and test scripts to /data
COPY install /data/install

COPY scripts /usr/local/scripts

RUN chmod +x /data/install/*.sh && chmod +x /usr/local/scripts/*  && export PATH=$PATH:/usr/local/scripts


# Required tools
ARG tools="mzdb-tools tpp maxquant msqrob sdrf-pipelines raw2mzml comet-ms cwlrunner"


# Install the tools
RUN  for a in $tools;do /data/install/install_$a.sh; done

RUN rm -rf /data/install 
