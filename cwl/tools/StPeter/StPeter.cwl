cwlVersion: v1.0
class: CommandLineTool
baseCommand: "/usr/local/tpp/bin/StPeter"
label: StPeter.cwl
inputs:
  StPeter_in_1:
    type: File
    format:  "http://edamontology.org/format_3747" # protXML
    inputBinding:
      position: 1

outputs:
   StPeter_out_1: 
     type: File
     format: "http://edamontology.org/format_3747" # protXML
     outputBinding:
       glob: ../..$(inputs.StPeter_in_1.path)
   StPeter_out_2: 
     type: File
     format: "http://edamontology.org/format_3747" # protXML
     outputBinding:
       glob: ../..$(inputs.StPeter_in_1.path)

        