cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["wget", "https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/Comet/comet.params"]
label: comet-ms
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.Comet_in_1)
      - $(inputs.Comet_in_2)
hints:
  DockerRequirement:
    dockerPull: spctools/tpp
arguments:
  - valueFrom: "&& /usr/local/tpp/bin/comet -Pcomet.params"
    position: 1
    shellQuote: false
  - valueFrom: $(inputs.Comet_in_1.nameroot)
    prefix: -N
    position : 2
    separate: false
  
inputs:
  Comet_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    inputBinding:
      position: 4
      separate: false
      valueFrom: $(self.basename)
  Comet_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
    inputBinding:
      position: 3
      prefix: -D
      separate: false
      valueFrom: $(self.basename)


outputs:
    Comet_out_1: 
      type: File
      format: "http://edamontology.org/format_3655" # pepXML
      outputBinding:
        glob: "*.pep.xml"


      
