cwlVersion: v1.0
class: CommandLineTool
baseCommand: ms_amanda
label: ms_amanda
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.MS_Amanda_in_1)
      - $(inputs.MS_Amanda_in_2)
      - $(inputs.Params)
  DockerRequirement:
    dockerPull: spctools/tpp
    dockerOutputDirectory: /data
arguments:
  - valueFrom: "-Psettings.xml"
    position: 1
    shellQuote: false
  
inputs:
  Params:
    type: File
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/containers/main/cwl/tools/MS_Amanda/settings.xml
  MS_Amanda_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  MS_Amanda_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
    inputBinding:
      position: 2
      prefix: -D
      separate: false
      valueFrom: $(self.basename)


outputs:
    MS_Amanda_out_1: 
      type: File
      format: "http://edamontology.org/format_3247" # mzIdentML
      outputBinding:
        glob: "*.mzid"


      
