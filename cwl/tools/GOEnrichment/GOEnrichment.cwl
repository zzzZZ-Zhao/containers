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
inputs:
  Jar:
    type: File
    inputBinding:
        prefix: -jar
        position: 1
    default:
      class: File
      location: https://github.com/DanFaria/GOEnrichment/releases/download/v2.0.1/GOEnrichment.jar
    
     


  GOEnrichment_in_1:
    type: File
    format: "http://edamontology.org/format_2330" # Textual format
    inputBinding:
        prefix: "-s"
        position: 2
  GOEnrichment_in_2:
    type: File
    format: "http://edamontology.org/format_2196" # OBO format
    inputBinding:
        prefix: "-g"
        position: 3
  GOEnrichment_in_3:
    type: File
    format: "http://edamontology.org/format_3475" # TSV
    inputBinding:
        prefix: "-a"
        position: 4

outputs:
  GOEnrichment_out_1:
    type: File
    format: "http://edamontology.org/format_2330" # Textual format
    outputBinding:
      glob: "MF_result.txt"

