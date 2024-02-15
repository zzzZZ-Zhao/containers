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
    dockerPull: spctools/tpp:version6.3.3
  
inputs:
  Params:
    type: File
    inputBinding:
      prefix: -P
      position: 1
      separate: false
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/containers/main/cwl/tools/Comet/comet.params
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
    Comet_out_2: 
      type: File
      format: "http://edamontology.org/format_3247" # mzIdentML
      outputBinding:
        glob: "*.mzid"


      
