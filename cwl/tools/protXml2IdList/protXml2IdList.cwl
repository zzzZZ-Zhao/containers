#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["xmllint", "--xpath",  "//*[local-name()='protein']/@protein_name"]
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: pipelinecomponents/xmllint
    dockerOutputDirectory: /data
arguments:
- valueFrom: "| cut -d '|' -f2 > output_protxml2idlist.txt"
  position: 2
  shellQuote: false

inputs:
  protXml2IdList_in_1:
    type: File
    format: "http://edamontology.org/format_3747" # protXML
    inputBinding:
      position: 1

outputs:
  protXml2IdList_out_1:
    type: File
    format: "http://edamontology.org/format_2330" # Textual format
    outputBinding:
      glob: "output_protxml2idlist.txt"

