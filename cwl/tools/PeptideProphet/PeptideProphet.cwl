cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["/usr/local/tpp/bin/xinteract", "-Noutput_interact.pep.xml" , "-p0.95" , "-l7" , "-PPM"]
label: PeptideProphet.cwl
requirements:
  DockerRequirement:
    dockerPull: spctools/tpp
    dockerOutputDirectory: /data
  InitialWorkDirRequirement:
    listing:
      - $(inputs.PeptideProphet_in_1)
      - $(inputs.PeptideProphet_in_2)
inputs:
  PeptideProphet_in_1:  # 2021-10-8_Ecoli.pep.xml
    type: File
    format: "http://edamontology.org/format_3655" # pepXML
    inputBinding:
      position: 1
    secondaryFiles:  # 2021-10-8_Ecoli.mzML
      - ^^.mzML
  PeptideProphet_in_2: 
    type: File
    format: "http://edamontology.org/format_1929" # FASTA
outputs:
    PeptideProphet_out_1: 
      type: File
      format: "http://edamontology.org/format_3655" # pepXML
      outputBinding:
        glob: "output_interact.pep.xml"


    