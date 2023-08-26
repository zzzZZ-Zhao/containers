#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: GOEnrichment.cwl

baseCommand: ["java", "-jar", "/usr/local/GOEnrichment/GOEnrichment.jar"]

inputs:
  GOEnrichment_in_1:
    type: File
    format: "http://edamontology.org/format_2330" # Textual format
    inputBinding:
        prefix: "-s"
        position: 1
  GOEnrichment_in_2:
    type: File
    format: "http://edamontology.org/format_2196_plain" # OBO format
    inputBinding:
        prefix: "-g"
        position: 2
  GOEnrichment_in_3:
    type: File
    format: "http://edamontology.org/format_3475_plain" # TSV_p
    inputBinding:
        prefix: "-a"
        position: 3

outputs:
  GOEnrichment_out_1:
    type: File
    format: "http://edamontology.org/format_2330" # Textual format
    outputBinding:
      glob: "*.txt"

