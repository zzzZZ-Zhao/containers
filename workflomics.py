#!/usr/bin/env python3

import argparse
import subprocess
import os
import yaml

docker_image_name="workflomics/container:v1.0"

def construct_docker_run_command(workflow_path, input_yaml, output_dir):
    # Load the input YAML
    with open(input_yaml, 'r') as yaml_file:
        input_data = yaml.load(yaml_file, Loader=yaml.FullLoader)
    #with open(os.path.join(os.path.dirname(input_yaml), "workflomics_input.yaml"), 'w') as workflomics_in_yaml_file:

    workflomics_input_data = input_data.copy()

    docker_command = [
        "docker", "run", "--rm",
        "-v", f"{os.path.dirname(workflow_path)}:/workflowDir",
        "-v", f"{os.path.dirname(input_yaml)}:/inputYmlDir",
        "-v", f"{os.path.abspath(output_dir)}:/output",
    ]
    input_dirs_map = {}
    i = 1
    for input_info in input_data.values():
        if 'path' in input_info:
            input_dirs_map[input_info['path']] = f"/inputDir{i}/{os.path.basename(input_info['path'])}"
        if 'path' not in input_dirs_map.keys():
            i += 1

    for input_info in workflomics_input_data.values():
        if 'path' in input_info:
            input_info['path'].replace(input_info['path'], input_dirs_map[input_info['path']])
    with open(os.path.join(os.path.dirname(input_yaml), "workflomics_input.yaml"), 'w') as workflomics_in_yaml_file:
        yaml.dump(workflomics_input_data, workflomics_in_yaml_file)
    
    # Loop through directories containing input data and mount them
    input_dirs = set(os.path.dirname(input_info['path']) for input_info in input_data.values() if 'path' in input_info)
    i = 1
    for input_dir in input_dirs:
        docker_command.extend(["-v", f"{os.path.abspath(input_dir)}:/inputDir{i}"])
        i += 1

    docker_command.extend([
        docker_image_name,  # Replace with the actual Docker image name
        "cwl-runner", "--leave-tmpdir", "--outdir", "/output", "/workflowDir/" + os.path.basename(workflow_path), "/inputYmlDir/" + os.path.basename(workflomics_in_yaml_file.name)
    ])

    return docker_command

def main():
    parser = argparse.ArgumentParser(description="Execute a Dockerized CWL workflow.")
    parser.add_argument("run", help="Run the specified workflow", nargs=1)
    parser.add_argument("--workflow", required=True, help="Path to the workflow CWL file")
    parser.add_argument("--inYml", required=True, help="Path to the input YAML file")
    parser.add_argument("--outDir", required=True, help="Output directory")

    args = parser.parse_args()

    docker_command = construct_docker_run_command(args.workflow, args.inYml, args.outDir)

    try:
        subprocess.run(docker_command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")
        exit(1)

if __name__ == "__main__":
    main()
