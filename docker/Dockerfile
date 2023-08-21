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


RUN apt -y update && apt -y upgrade && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy the install and test scripts to /data
COPY install /data/install

COPY scripts /usr/local/scripts


# Required tools
#ARG tools="mzdb-tools tpp maxquant msqrob sdrf-pipelines raw2mzml cwlrunner mzrecal goenrichment"
#ARG tools="tpp cwlrunner"
ARG tools="goenrichment"


# Install the tools
RUN for tool in $tools;do chmod +x /data/install/install_$tool.sh &&  /data/install/install_$tool.sh; done

# Install the scripts
RUN for script in /usr/local/scripts/*;do chmod +x $script; done

# Add the scripts to the path
ENV PATH="${PATH}:/usr/local/scripts"



RUN rm -rf /data/install 
