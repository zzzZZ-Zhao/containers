#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: XTandem.cwl
baseCommand: ["mkdir", "/tmp/XTandem"]
requirements:
  ShellCommandRequirement: {}
arguments:
    - valueFrom:    "&& wget -O /tmp/XTandem/tandem.params https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/XTandem/tandem.params && \
                    wget  -O /tmp/XTandem/taxonomy.xml https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/XTandem/taxonomy.xml &&"
      position: 1
      shellQuote: false
    - valueFrom:    "cp"
      position: 2
      shellQuote: false
    - valueFrom:    $(inputs.XTandem_in_1.path)
      position: 3
      shellQuote: false
    - valueFrom:    "/tmp/XTandem/mzmlFile.mzML"
      position: 4
      shellQuote: false
    - valueFrom:    "&& cp"
      position: 5
      shellQuote: false
    - valueFrom: $(inputs.XTandem_in_2.path)
      position: 6
      shellQuote: false
    - valueFrom:    "/tmp/XTandem/fastaFile.fasta"
      position: 7
      shellQuote: false
    - valueFrom:    "&& /usr/local/tpp/bin/tandem /tmp/XTandem/tandem.params && \
                    /usr/local/tpp/bin/Tandem2XML /tmp/XTandem/tandemFile.tandem > output.pep.xml"
      position: 8
      shellQuote: false
inputs:
  XTandem_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
  XTandem_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA

outputs:
  XTandem_out_1:
    type: File
    format: "http://edamontology.org/format_3247" # mzIdentML
    outputBinding:
      glob: "tandemFile.tandem"