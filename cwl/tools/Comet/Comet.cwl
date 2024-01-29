cwlVersion: v1.0
class: CommandLineTool
baseCommand: comet
label: comet-ms
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.Comet_in_1)
      - $(inputs.Comet_in_2)
      - $(inputs.Params)
  DockerRequirement:
    dockerPull: spctools/tpp
    dockerOutputDirectory: /data
arguments:
  - valueFrom: "-Pcomet.params"
    position: 1
    shellQuote: false
  # - valueFrom: $(inputs.Comet_in_1.nameroot)
  #   prefix: -N
  #   position : 2
  #   separate: false
  
inputs:
  Params:
    type: File
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/Comet/comet.params
  Comet_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  Comet_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
    inputBinding:
      position: 2
      prefix: -D
      separate: false
      valueFrom: $(self.basename)


outputs:
    Comet_out_1: 
      type: File
      format: "http://edamontology.org/format_3655" # pepXML
      outputBinding:
        glob: "*.pep.xml"
      # secondaryFiles:
      #   - ^^.mzML 


      
