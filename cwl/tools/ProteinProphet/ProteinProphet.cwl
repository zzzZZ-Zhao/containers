cwlVersion: v1.0
class: CommandLineTool
baseCommand: "/usr/local/tpp/bin/ProteinProphet"
label: ProteinProphet.cwl
# We need to specify the positions of additional command line args,
# because PeptideProphet expects the input file as the first argument,
# and options/output filename as further arguments
arguments:
  - position: 2
    valueFrom: "prot.protXML"
  - position: 3
    valueFrom: "EXCELPEPS"
inputs:
  ProteinProphet_in_1:
    type: File
    format: "http://edamontology.org/format_3655" # pepXML
    inputBinding:
      position: 1

outputs:
# We don't use the protXML output file
#    ProteinProphet_out_dummy: 
#      type: File
#      format: "http://edamontology.org/format_3747" # protXML
#      outputBinding:
#        glob: "*.protXML"
    ProteinProphet_out_1: 
      type: File
      format: http://edamontology.org/format_3475 # ProteinProphet promises xls, but actual output is TSV!
      outputBinding:
        glob: "*.xls"
        

    