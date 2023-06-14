
# Workflomics_v1.0 container

## Building
```
git clone https://github.com/Workflomics/containers.git
cd containers
git checkout docker
docker build -t workflomics_v1.0 -f docker/Dockerfile .

```
## Running an example CWL workflows

Enable file sharing for the `data` and `cwl` directory. With Docker Desktop dashboard this could be achived with Settings -> Resources -> File sharing   


Run the CWL workflow inside the container

Example 1: Comet -> PeptideProphet -> ProteinProphet

```
docker run -v ./cwl:/cwl -v ./data:/data  workflomics_v1.0 cwl-runner --leave-tmpdir --outdir /data/output /cwl/workflows/example1/workflow.cwl /cwl/workflows/example1/inp.yml
```
Example 2:  Comet -> PeptideProphet -> ProteinProphet -> StPeter

```
docker run -v ./cwl:/cwl -v ./data:/data  workflomics_v1.0 cwl-runner --leave-tmpdir --outdir /data/output /cwl/workflows/example2/workflow.cwl /cwl/workflows/example2/inp.yml
```