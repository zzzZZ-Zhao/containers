#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: idconvert.cwl

baseCommand: "/usr/local/tpp/bin/idconvert"

inputs:
  idconvert_in_1:
    type: File
    format: "http://edamontology.org/format_3655" # protXML
    inputBinding:
      position: 1

outputs:
  idconvert_out_1:
    type: File
    format: "http://edamontology.org/format_3247" # mzIdentML
    outputBinding:
      glob: "*.mzID"

