cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["wget", "https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/Comet/comet.params" , "&&", "/usr/local/tpp/bin/comet", "-Pcomet.params"]
label: comet-ms
arguments:
  - valueFrom: $(inputs.Comet_in_1.nameroot)
    prefix: -N
    position : 1
    separate: false
inputs:
  Comet_in_1:
    type: File
    secondaryFiles:
      - "http://edamontology.org/format_3244"
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


      
