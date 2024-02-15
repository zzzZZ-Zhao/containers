cwlVersion: v1.0
class: CommandLineTool
baseCommand: "ProteinProphet"
label: ProteinProphet.cwl
requirements:
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3
  InitialWorkDirRequirement:
    listing:
      - $(inputs.ProteinProphet_in_2)
# We need to specify the positions of additional command line args,
# because PeptideProphet expects the input file as the first argument,
# and options/output filename as further arguments
arguments:
  - position: 2
    valueFrom: "output_proteinprophet.prot.xml"
  - position: 3
    valueFrom: "EXCELPEPS"
inputs:
  ProteinProphet_in_1:
    type: File
    format: "http://edamontology.org/format_3655" # pepXML
    inputBinding:
      position: 1
  ProteinProphet_in_2:
    type: File
    format: "http://edamontology.org/format_1929" # FASTA

outputs:
    ProteinProphet_out_1: 
     type: File
     format: "http://edamontology.org/format_3747" # protXML
     outputBinding:
       glob: "output_proteinprophet.prot.xml"
    ProteinProphet_out_2: 
      type: File
      format: http://edamontology.org/format_3475 # ProteinProphet promises xls, but actual output is TSV!
      outputBinding:
        glob: "*.xls"


        

     