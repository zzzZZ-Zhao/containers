cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["mkdir"]
requirements:
  ShellCommandRequirement: {}
arguments:
- valueFrom: "| cut -d '|' -f2 > output.txt"
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
      glob: "output.txt"