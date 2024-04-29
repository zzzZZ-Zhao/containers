cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["bash"]
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.Params)
inputs:
  Params:
    type: File
    inputBinding:
      prefix: -P
      position: 1
      separate: false
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/containers/docker/cwl/tools/gProfiler/gProfiler.sh
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
      glob: "output.json"
