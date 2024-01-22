import subprocess
import argparse
import yaml
import re
import json
import datetime
from pathlib import Path
from loggingwrapper import LoggingWrapper

from .cwltool_runtime_benchmark import CWLToolRuntimeBenchmark
from cwltool_runner import CWLToolRunner

KNOWN_USELESS_WARNINGS_ERRORS = ["WARNING: The requested image's platform", "with 0 errors", "Calculating sensitivity...and error tables..."]

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

def is_line_useless(line):
    for useless in KNOWN_USELESS_WARNINGS_ERRORS:
        if useless in line:
            return True
    return False

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
        output_lines = result.stdout.split('\n')
        workflow_name = Path(args.workflow).name
        success_pattern = re.compile(r'\[job (.+)\] completed success')
        fail_pattern = re.compile(r'\[job (.+)\] completed permanentFail')
        success_steps = set()
        step_results = [{"step": step, "result": "not executed", "time": "", "memory": "", "warnings": [], "errors": []} for step in steps]
        for line in output_lines:
            if success_pattern.search(line):
                success_steps.add(success_pattern.search(line).group(1))
            elif fail_pattern.search(line):
                step_results[fail_pattern.search(line).group(1)]["result"] = "fail"
                step_results[fail_pattern.search(line).group(1)]["time"] = ""
                step_results[fail_pattern.search(line).group(1)]["memory"] = "")
    
        for step in success_steps:
            max_memory_step = "not measured"
            step_start = False
            warnings_step = []
            errors_step = []
            for line in output_lines:
                if f'[step {step}] start' in line:
                    start_time_step = datetime.datetime.strptime(line[:21], '[%Y-%m-%d %H:%M:%S]')
                    step_start = True
                elif f'[job {step}] completed success' in line:
                    end_time_step = datetime.datetime.strptime(line[:21], '[%Y-%m-%d %H:%M:%S]')
                    break
                elif step_start:
                    if f'[job {step}] Max memory used' in line:
                        max_memory_step = line.split()[-1]
                    elif "warning" in line.lower():
                        if not is_line_useless(line):
                            warnings_step.append(line)
                    elif "error" in line.lower():
                        if not is_line_useless(line):
                            errors_step.append(line)
                    

            execution_time_step = (end_time_step - start_time_step).total_seconds()
            for entry in step_results:
                if entry["step"] == step:
                    entry["result"] = "success"
                    entry["time"] = execution_time_step
                    entry["memory"] = max_memory_step
                    entry["warnings"] = warnings_step
                    entry["errors"] = errors_step

                

        data = {
            "n_steps": len(steps),
            "steps": step_results,
        }

        return data

    elif args.subcommand == 'run':
        result = subprocess.run(command)
        print(result.stdout)
        return None

def run_workflows(args, version, inputs):
    '''Run the workflows in the given directory and store the results in a json file.'''
    all_workflow_data = {
        "executor": "cwltool " + version,
        "inputs":{key: {"filename": inputs[key]["filename"], "size": inputs[key]["size"]} for key in inputs},
        "units":{"time": "seconds", "memory": "megabytes"},
        "workflows": {},
    }
    for workflow_path in args.workflow:
        args.workflow = workflow_path
        inputs_copy = inputs.copy()
        workflow_data = run_workflow(args, version, inputs_copy)
        if workflow_data is not None:
            workflow_name = Path(workflow_path).name
            if workflow_name in all_workflow_data["workflows"]:
                workflow_name = workflow_name + "_1"
            all_workflow_data["workflows"][workflow_name] = workflow_data
    if args.subcommand == 'benchmark':
        with open(f"{args.outdir}/benchmark_output.json", 'w') as f:
            json.dump(all_workflow_data, f, indent=4)
        LoggingWrapper.info("Benchmark results are stored in" + f"{args.outdir}/benchmark_output.json")


if __name__ == '__main__':
    
    
    version = check_cwltool()


    parser = argparse.ArgumentParser(description='Wrapper for cwltool command.')
    parser.add_argument('--singularity', action='store_true', help='Use singularity instead of docker.')
    parser.add_argument('-o','--outdir', required=True, help='Path to the output directory to store the results.')
    parser.add_argument('-w','--workflow', nargs='+', required=True, help='Path to the workflows directory or a list of workflows.')
    parser.add_argument('-v', '--verbose', action='store_true', help='Print the output of the cwltool command.')
    parser.add_argument('-i','--input', required=True, help='Path to the input yaml file.')
    subparcers = parser.add_subparsers(dest='subcommand', help='Subcommands.')
    parser_benchmark = subparcers.add_parser('benchmark', help='Run the benchmark.')
    parser_run = subparcers.add_parser('run', help='Run the workflow.')

    args = parser.parse_args()
    if all(Path(workflow).is_dir() for workflow in args.workflow):
        args.workflow = [str(file) for file in Path(args.workflow[0]).glob('*.cwl')]
    
    if (args.subcommand == "benchmark"):
        op = CWLToolRuntimeBenchmark(args, parser_benchmark)
    elif (args.subcommand == "run"):
        op = CWLToolRunner(args, parser_run)    

    op.run_workflows()

    inputs = update_input_yaml(args.input)
    run_workflows(args, version, inputs)
