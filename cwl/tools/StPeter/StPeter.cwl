cwlVersion: v1.0
class: CommandLineTool
baseCommand: "StPeter"
label: StPeter.cwl
requirements:
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3
    dockerOutputDirectory: /data
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.StPeter_in_1)
        writable: true
      - $(inputs.StPeter_in_2)
      - $(inputs.StPeter_in_3)
inputs:
  StPeter_in_1:
    type: File
    format:  "http://edamontology.org/format_3747" # protXML
    inputBinding:
      position: 1
  StPeter_in_2:
    type: File
    format: "http://edamontology.org/format_3655" # pepXML
  StPeter_in_3:
    type: File
    format: "http://edamontology.org/format_3244" # mzML
    

outputs:
   StPeter_out_1: 
     type: File
     format: "http://edamontology.org/format_3747" # protXML
     outputBinding:
       glob: $(inputs.StPeter_in_1.basename)

        
