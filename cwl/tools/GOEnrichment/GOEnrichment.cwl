#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: GOEnrichment.cwl
requirements:
 ShellCommandRequirement: {}
 DockerRequirement:
    dockerPull: eclipse-temurin:latest
 InitialWorkDirRequirement:
    listing:
      - $(inputs.Jar)
baseCommand: java
arguments:
  - valueFrom: "-jar GOEnrichment.jar"
    position: 1
    shellQuote: false
inputs:
  Jar:
    type: File
    default:
      class: File
      location: https://github.com/DanFaria/GOEnrichment/releases/download/v2.0.1/GOEnrichment.jar
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
      glob: "MF_result.txt"

