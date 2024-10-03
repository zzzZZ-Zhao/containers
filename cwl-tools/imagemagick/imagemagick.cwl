cwlVersion: v1.2
class: CommandLineTool
baseCommand: magick
label: imagemagick-convert
requirements:
  ShellCommandRequirement: {}

inputs:
  magick_in_1:  #input path
    type: File
    format: 
      - "http://edamontology.org/format_3579" #JPG
      - "http://edamontology.org/format_3603" #PNG
      - "http://edamontology.org/format_3727" #OME-TIFF
      - "http://edamontology.org/format_3591" #TIFF
      - "http://edamontology.org/format_3467" #GIF
      - "http://edamontology.org/format_3594" #PCD
    inputBinding:
      position: 1
      valueFrom: $(self.path)

  magick_in_2:  #output file format
    type: string
    inputBinding:
      position: 2
      valueFrom: $(self)

outputs:
  magick_out_1:
    type: File
    outputBinding: 
      glob: "$(inputs.magick_in_2)"


  