cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["/usr/local/tpp/bin/comet", "-P/cwl/tools/Comet/comet.params"]
label: comet-ms
# requirements:
#   InlineJavascriptRequirement: {}
arguments:
  - valueFrom: $(inputs.Comet_in_1.nameroot)
    prefix: -N
    position : 1
    separate: false

inputs:
  Comet_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    inputBinding:
      position: 3
  Comet_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
    inputBinding:
      position: 2
      prefix: -D
      separate: false


outputs:
    Comet_out_1: 
      type: File
      format: "http://edamontology.org/format_3655" # pepXML
      outputBinding:
        glob: "*.pep.xml"


      
