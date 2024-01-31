#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: idconvert.cwl

baseCommand: "/usr/local/tpp/bin/idconvert"
requirements:
  DockerRequirement:
    dockerPull: spctools/tpp

inputs:
  idconvert_in_1:
    type: File
    format: "http://edamontology.org/format_3247" # mzIdentML
    inputBinding:
      position: 1

outputs:
  idconvert_out_1:
    type: File
    format: "http://edamontology.org/format_3655" # pepXML
    outputBinding:
      glob: "*.pep.xml"
