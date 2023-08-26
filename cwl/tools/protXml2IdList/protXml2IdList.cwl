#!/usr/bin/env cwl-runner

# cwlVersion: v1.0
# class: CommandLineTool
# baseCommand: ["conda", "run" , "-n", "protxml2idlist","xmllint", "--xpath",  "//*[local-name()='protein']/@protein_name", $(inputs.protXml2IdList_in_1.path), "| cut -d '|' -f2 > output.txt"]

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
#       glob: "output.txt"


cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["bash", "/cwl/tools/protXml2IdList/protXml2IdList.sh"]

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
      glob: "id_list.txt"