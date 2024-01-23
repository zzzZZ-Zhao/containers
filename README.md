
# Workflomics version 2.0

## Requirements
- cwltool (Tested with cwltool 3.1.20230719185429)
- python (Tested with Python 3.9.12)
- docker (Tested with Docker version 24.0.6, build ed223bc)
- singularity/apptainer (optional) (Tested with singularity version 1.1.6)


## Running and benchmarking CWL workflows

Clone the repository and checkout the continerless branch:
```
git clone https://github.com/Workflomics/containers.git
cd containers
git checkout continerless
```

Create `data` directory and a `outputs` subdirectory. Enable file sharing for the `data` and `cwl` directory. With Docker Desktop dashboard this could be achived with Settings -> Resources -> File sharing. For running example2 workflow (Comet -> PeptideProphet -> ProteinProphet -> StPeter), run the following command in the root directory of the project. The command is tested on Ubuntu. Update the paths according to your OS:
 
```
python cwltool_wrapper.py run --outdir ./data/outputs --workflow ./cwl/workflows/example2/workflow_2.cwl --input ./cwl/workflows/example2/input.yml
```
The command will ask you to enter the paths to the input files. The output files will be saved in `./data/outputs`. The --workflow flag specifies the path to a directory containing workflows or a list of space-separated path to workflow files.

To benchmark the workflow, run the following command in the root directory of the project. The command is tested on Ubuntu. Update the paths according to your OS:

```
python cwltool_wrapper.py benchmark --outdir ./data/outputs --workflow ./cwl/workflows/example2/workflow_2.cwl --input ./cwl/workflows/example2/input.yml
```

Bechmarking results will be saved in `./data/outputs/benchmarking_results.json`. 

Using the `--singularity` flag will run the workflow using singularity instead of docker.
