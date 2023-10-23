import subprocess
import argparse
import yaml
import re
import json
import datetime
from pathlib import Path

def check_cwltool():
    try:
        result = subprocess.run(['cwltool', '--version'], capture_output=True, text=True)
        version = result.stdout.strip().split()[-1]
        print(f"Using cwltool {version}")
    except FileNotFoundError:
        print("cwltool is not installed.")
    return version

def update_input_yaml(input_yaml_path):
    inputs = {}
    with open(input_yaml_path, 'r') as file:
        input_data = yaml.safe_load(file)

    for key, value in input_data.items():
        if key.startswith('input'):
            new_path = input(f"Enter the path for {key}: ")
            value['path'] = new_path.strip()
            inputs[key] = {"filename": Path(value['path']).name, "size": Path(value['path']).stat().st_size}

    with open(input_yaml_path, 'w') as file:
        documents = yaml.dump(input_data, file)
    return inputs

def extract_steps_from_cwl(workflow_file):
    with open(workflow_file, 'r') as file:
        data = yaml.safe_load(file)
    steps = []
    for step_name in data.get('steps', {}):
        steps.append(step_name)
    return steps


def run_workflow(args, version, inputs):
    if args.subcommand == 'run':
        command = ['cwltool']
    elif args.subcommand == 'benchmark':
        command = ['cwltool']
    else:
        raise ValueError("Invalid subcommand. Please use 'run' or 'benchmark'.")

    if args.singularity:
        command.append('--singularity')

    command.extend(['--disable-color', '--timestamps', '--outdir', args.outdir, args.workflow, args.input])

    if args.subcommand == 'benchmark':
        steps = extract_steps_from_cwl(args.workflow)
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8')
        #print(result.stdout)
        output_lines = result.stdout.split('\n')
        #print(output_lines)
        workflow_name = Path(args.workflow).name
        #step_pattern = re.compile(r'\[workflow ] starting step (.+)')
        success_pattern = re.compile(r'\[job (.+)\] completed success')
        fail_pattern = re.compile(r'\[job (.+)\] completed permanentFail')
        success_steps = set()
        #fail_steps = set()
        step_results = {step: {"result": "not executed", "time": ""} for step in steps}
        for line in output_lines:
            #match = step_pattern.search(line)
            # if match:
            #     step_name = match.group(1)
            #     step_results[step_name]["result"] = "fail"
            #success_match = success_pattern.search(line)
            if success_pattern.search(line):
                success_steps.add(success_pattern.search(line).group(1))
            elif fail_pattern.search(line):
                step_results[fail_pattern.search(line).group(1)]["result"] = "fail"
                step_results[fail_pattern.search(line).group(1)]["time"] = ""

    
        print(success_steps)
        #print(fail_steps)
        for step in success_steps:
            for line in output_lines:
                if f'[step {step}] start' in line:
                    start_time_step = datetime.datetime.strptime(line[:21], '[%Y-%m-%d %H:%M:%S]')
                elif f'[job {step}] completed success' in line:
                    end_time_step = datetime.datetime.strptime(line[:21], '[%Y-%m-%d %H:%M:%S]')
            execution_time_step = (end_time_step - start_time_step).total_seconds()
            step_results[step]["result"] = "success"
            step_results[step]["time"] = execution_time_step

                
        #execution_time = (end_time - start_time).total_seconds()
        data = {
            "n_steps": len(steps),
            "steps": {step: {"result": step_results[step]["result"], "time": step_results[step]["time"]} for step in steps}
        }
        #with open(f"{args.outdir}/benchmark_output.json", 'w') as f:
         #   json.dump(data, f, indent=4)
        return data
        #print(output_lines)
    elif args.subcommand == 'run':
        result = subprocess.run(command)
        print(result.stdout)

def run_workflows(args, version, inputs):
    all_workflow_data = {
        "executor": "cwltool " + version,
        "inputs":{key: {"filename": inputs[key]["filename"], "size": inputs[key]["size"]} for key in inputs},
        "workflows": {},
    }
    for workflow_path in args.workflow:
        args.workflow = workflow_path
        inputs_copy = inputs.copy()
        workflow_data = run_workflow(args, version, inputs_copy)
        workflow_name = Path(workflow_path).name
        if workflow_name in all_workflow_data["workflows"]:
            workflow_name = workflow_name + "_1"
        all_workflow_data["workflows"][workflow_name] = workflow_data
    with open(f"{args.outdir}/benchmark_output.json", 'w') as f:
        json.dump(all_workflow_data, f, indent=4)


if __name__ == '__main__':
    version = check_cwltool()

    parser = argparse.ArgumentParser(description='Wrapper for cwltool command.')
    parser.add_argument('subcommand', choices=['run', 'benchmark'], help='Specify the subcommand to execute.')
    parser.add_argument('--singularity', action='store_true', help='Use singularity instead of docker.')
    parser.add_argument('--outdir', required=True, help='Path to the output directory to store the results.')
    parser.add_argument('--workflow', nargs='+', required=True, help='Path to the workflows directory or a list of workflows.')
    parser.add_argument('--input', required=True, help='Path to the input yaml file.')
    args = parser.parse_args()


    if all(Path(workflow).is_dir() for workflow in args.workflow):
        args.workflow = [str(file) for file in Path(args.workflow[0]).glob('*.cwl')]



    inputs = update_input_yaml(args.input)
    run_workflows(args, version, inputs)

