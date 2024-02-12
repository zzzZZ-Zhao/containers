cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["wget", "https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/gProfiler/gProfiler.sh"]
requirements:
  ShellCommandRequirement: {}
arguments:
    - valueFrom: "&& bash gProfiler.sh"
      position: 1
      shellQuote: false
inputs:
  gProfiler_in_1:
    type: File
    doc: "Input file containing gene/query data"
    inputBinding:
      position: 2
outputs:
  gProfiler_out_1:
    type: File
    doc: "Output file containing the result of the curl command"
    outputBinding:
      glob: "output.txt"
