cwlVersion: v1.2
class: CommandLineTool
baseCommand: python
label: MSIGen-CLI
requirements:
  ShellCommandRequirement: {}

inputs:
  msigen_in_1:  #python script path
    type: File
    inputBinding:
      position: 1
      valueFrom: $(self.path)

  msigen_in_2:  #config file path
    type: File
    inputBinding:
      position: 2
      valueFrom: $(self.path)

outputs:
  msigen_out_1:
    type: File[]
    outputBinding: 
      glob: ["*.png", "*.jpg", "*.tiff"]

  