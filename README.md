
# Workflomics_v1.0 container

## Building
```
git clone https://github.com/Workflomics/containers.git
cd containers
git checkout docker
docker build -t workflomics_v1.0 -f docker/Dockerfile .

```
## Running an example CWL workflow

Copy workflows and input data to docker volumes

```
docker volume create cwl_workflomics
docker volume create data_workflomics
docker run -v cwl_workflomics:/cwl -v data_workflomics:/data --name helper busybox true
docker cp ./data/inputs helper:/data/inputs
docker cp ./cwl/tools helper:/cwl/tools
docker cp ./cwl/workflows helper:/cwl/workflows
```
Run the CWL workflow inside the container

```
docker run -v cwl_workflomics:/cwl -v data_workflomics:/data  workflomics_v1.0 cwl-runner --outdir /data/output /cwl/workflows/example1/workflow.cwl /cwl/workflows/example1/inp.yml
```
