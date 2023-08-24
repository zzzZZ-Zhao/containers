cwlVersion: v1.0
class: CommandLineTool
baseCommand: [bash, gProfiler.sh]
requirements:
  ShellCommandRequirement: {}
inputs:
  input_file:
    type: File
    doc: "Input file containing gene/query data"
    inputBinding:
      position: 1
outputs:
  output_file:
    type: File
    doc: "Output file containing the result of the curl command"
    outputBinding:
      glob: "*.txt"
