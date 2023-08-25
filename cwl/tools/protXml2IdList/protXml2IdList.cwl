#!/usr/bin/env cwl-runner

# cwlVersion: v1.0
# class: CommandLineTool
# label: protXml2IdList.cwl

# baseCommand: ["conda", "run" , "-n", "protxml2idlist","xmllint", "--xpath",  "\"//*[local-name()='protein']/@protein_name\""]


# arguments:
#   - position: 1
#     valueFrom: |
#       --xpath "//*[local-name()='protein']/@protein_name" | cut -d '|' -f2 

# inputs:
#   protXml2IdList_in_1:
#     type: File
#     format: "http://edamontology.org/format_3747" # protXML
#     inputBinding:
#       position: 1

# outputs:
#   protXml2IdList_out_1:
#     type: File
#     format: "http://edamontology.org/format_2330" # Textual format
#     outputBinding:
#       glob: '*.txt'
cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["bash", "/cwl/tools/protXml2IdList/protXml2IdList.sh"]
requirements:
  ShellCommandRequirement: {}
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
      glob: '*.txt'

