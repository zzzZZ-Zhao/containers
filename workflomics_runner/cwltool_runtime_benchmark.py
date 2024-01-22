from cwltool_wrapper import CWLToolWrapper
import subprocess
from pathlib import Path
import re
import datetime
import json
from loggingwrapper import LoggingWrapper

class CWLToolRuntimeBenchmark(CWLToolWrapper):
    '''Runtime benchmarking class  to gather information about the runtime of each step in a workflow.'''

    KNOWN_USELESS_WARNINGS_ERRORS = ["WARNING: The requested image's platform", "with 0 errors", "Calculating sensitivity...and error tables..."]
    def __init__(self, args):
        super().__init__(args)
        self.benchmark_file = args.benchmark_file
        self.benchmark_data = {}

    def is_line_useless(self,line):
        '''Check if a line is useless for the benchmarking.'''
        for useless in self.KNOWN_USELESS_WARNINGS_ERRORS:
            if useless in line:
                return True
        return False

    def run_workflow(self, workflow):

        '''Run a workflow and gather information about the runtime of each step.'''
        command = ['cwltool']

        if  self.container == "singularity":
            command.append('--singularity')

        command.extend(['--disable-color', '--timestamps', '--outdir', self.outdir, workflow, self.input_yaml_path])
        
        print (command)
        steps = self.extract_steps_from_cwl(workflow)
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8')
        output_lines = result.stdout.split('\n')
        success_pattern = re.compile(r'\[job (.+)\] completed success')
        fail_pattern = re.compile(r'\[job (.+)\] completed permanentFail')
        success_steps = set()
        step_results = [{"step": step, "status": "not executed", "time": "", "memory": "", "warnings": [], "errors": []} for step in steps]
        for line in output_lines:
            if success_pattern.search(line):
                success_steps.add(success_pattern.search(line).group(1))
            elif fail_pattern.search(line):
                step_results[fail_pattern.search(line).group(1)]["status"] = "fail"
                step_results[fail_pattern.search(line).group(1)]["time"] = ""
                step_results[fail_pattern.search(line).group(1)]["memory"] = ""
                step_results[fail_pattern.search(line).group(1)]["warnings"] = []
                step_results[fail_pattern.search(line).group(1)]["errors"] = []

    
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
                        if not self.is_line_useless(line):
                            warnings_step.append(line)
                    elif "error" in line.lower():
                        if not self.is_line_useless(line):
                            errors_step.append(line)
                    

            execution_time_step = (end_time_step - start_time_step).total_seconds()
            for entry in step_results:
                if entry["step"] == step:
                    entry["status"] = "success"
                    entry["time"] = execution_time_step
                    entry["memory"] = max_memory_step
                    entry["warnings"] = warnings_step
                    entry["errors"] = errors_step

                

        self.benchmark_data = {
            "n_steps": len(steps),
            "steps": step_results,
        }



    # def run_workflows(self):
    #     '''Run the workflows in the given directory and store the results in a json file.'''
    #     all_workflow_data = {
    #         "executor": "cwltool " + self.version,
    #         "inputs":{key: {"filename": self.input[key]["filename"], "size": self.input[key]["size"]} for key in self.input},
    #         "units":{"time": "seconds", "memory": "megabytes"},
    #         "workflows": {},
    #     }
    #     for workflow_path in self.workflow:
    #         workflow_data = self.run_workflow(workflow_path)
    #         workflow_name = Path(workflow_path).name
    #         if workflow_name in all_workflow_data["workflows"]:
    #             workflow_name = workflow_name + "_1"
    #         all_workflow_data["workflows"][workflow_name] = workflow_data
    #     with open(self.benchmark_file, 'w') as f:
    #         json.dump(all_workflow_data, f, indent=4)
    #         LoggingWrapper.info("Benchmark results are stored in" + self.benchmark_file)

    def get_benchmark(self, name):
        '''Get a benchmark from the benchmark data.'''
        benchmark = []
        for entry in self.benchmark_data["steps"]:
                if entry["status"] != "not executed":
                    step_benchmark = {
                        "description": entry["step"],
                        "value": entry[name],
                        "desirability_value": 1,
                    }
                    benchmark.append(step_benchmark)
        return benchmark

    def run_workflows(self):
        '''Run the workflows in the given directory and store the results in a json file.'''

        for workflow_path in self.workflow:
            self.run_workflow(workflow_path)
            all_workflow_data = {
            "workflowName": "",
            "executor": "cwltool " + self.version,
            "runID": "39eddf71ea1700672984653",
            "inputs":{key: {"filename": self.input[key]["filename"], "size": self.input[key]["size"]} for key in self.input},
            "benchmarks": []
            }
            workflow_name = Path(workflow_path).name
            all_workflow_data["workflowName"] = workflow_name
            values = 0
            for entry in self.benchmark_data["steps"]:
                if entry["status"] != "not executed":
                    values = values + 1
            
            all_workflow_data["benchmarks"].append({
                                                    "benchmark_long_title": "Execution time",
                                                    "benchmark_description": "Execution time for each step in the workflow",
                                                    "benchmark_title": "Execution time",
                                                    "benchmark_unit": "seconds",
                                                    "values": str(values) + "/" + str(len(self.benchmark_data["steps"])),
                                                    "steps": self.get_benchmark("time"),
                                                    })
            all_workflow_data["benchmarks"].append({"benchmark_long_title": "Memory usage",
                                                    "benchmark_description": "Memory usage for each step in the workflow",
                                                    "benchmark_title": "Memory usage",
                                                    "benchmark_unit": "megabytes",
                                                    "values": str(values) + "/" + str(len(self.benchmark_data["steps"])),
                                                    "steps": self.get_benchmark("memory"),
                                                    })
            all_workflow_data["benchmarks"].append({"benchmark_long_title": "Warnings",
                                                    "benchmark_description": "Warnings for each step in the workflow",
                                                    "benchmark_title": "Warnings",
                                                    "benchmark_unit": "warnings",
                                                    "values": str(values) + "/" + str(len(self.benchmark_data["steps"])),
                                                    "steps": self.get_benchmark("warnings"),
                                                    })
            all_workflow_data["benchmarks"].append({"benchmark_long_title": "Errors",
                                                    "benchmark_description": "Errors for each step in the workflow",
                                                    "benchmark_title": "Errors",
                                                    "benchmark_unit": "errors",
                                                    "values": str(values) + "/" + str(len(self.benchmark_data["steps"])),
                                                    "steps": self.get_benchmark("errors"),
                                                    })
            all_workflow_data["benchmarks"].append({"benchmark_long_title": "Status",
                                                    "benchmark_description": "Status for each step in the workflow",
                                                    "benchmark_title": "Status",
                                                    "benchmark_unit": "status",
                                                    "values": str(len(self.benchmark_data["steps"])) + "/" + str(len(self.benchmark_data["steps"])),
                                                    "steps": self.get_benchmark("status"),
                                                    })



            with open(self.outdir + "/" + workflow_name + "_benchmark.json", 'w') as f:
                json.dump(all_workflow_data, f, indent=4)
                LoggingWrapper.info("Benchmark results for " + workflow_name + " are stored in" + self.outdir + "/" + workflow_name + "_benchmark.json")