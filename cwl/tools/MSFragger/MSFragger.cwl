cwlVersion: v1.0
class: CommandLineTool
baseCommand: msfragger
label: msfragger
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.MSFragger_in_1)
      - $(inputs.MSFragger_in_2)
      - $(inputs.Params)
  DockerRequirement:
    dockerPull: spctools/tpp
    dockerOutputDirectory: /data
arguments:
  - valueFrom: "-Pcomet.params"
    position: 1
    shellQuote: false
  
inputs:
  Params:
    type: File
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/containers/main/cwl/tools/MSFragger/fragger.params
  MSFragger_in_1:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  MSFragger_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
    inputBinding:
      position: 2
      prefix: -D
      separate: false
      valueFrom: $(self.basename)


outputs:
    MSFragger_out_1: 
      type: File
      format: "http://edamontology.org/format_3655" # pepXML
      outputBinding:
        glob: "*.mzid"


      
