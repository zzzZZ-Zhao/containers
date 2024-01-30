from cwltool_wrapper import CWLToolWrapper
import subprocess
from pathlib import Path
import os
import re
import datetime
import json
from loggingwrapper import LoggingWrapper

class CWLToolRuntimeBenchmark(CWLToolWrapper):
    """Runtime benchmarking class  to gather information about the runtime of each step in a workflow."""

    KNOWN_USELESS_WARNINGS_ERRORS = ["WARNING: The requested image's platform", "with 0 errors", "Calculating sensitivity...and error tables..."]
    EXECUTION_TIME_DESIRABILITY_BINS = {"0-60":1, "61-120":0.9, "121-180":0.8, "181-240":0.7, "241-300":0.6, "301-360":0.5, "361-420":0.4, "421-480":0.3, "481-540":0.2, "541-600":0.1, "601+":0}
    MAX_MEMORY_DESIRABILITY_BINS = {"0-100":1, "101-200":0.9, "201-300":0.8, "301-400":0.7, "401-500":0.6, "501-600":0.5, "601-700":0.4, "701-800":0.3, "801-900":0.2, "901-1000":0.1, "1001+":0}
    WARNINGS_DESIRABILITY_BINS = {"0-0":1, "1-1":0.9, "2-2":0.8, "3-3":0.7, "4-4":0.6, "5-5":0.5, "6-6":0.4, "7-7":0.3, "8-8":0.2, "9-9":0.1, "10+":0}

    def __init__(self, args):
        super().__init__(args)
        self.workflow_benchmark_result = {}
       

    def is_line_useless(self,line):
        """Check if a line is useless for the benchmarking."""
        for useless in self.KNOWN_USELESS_WARNINGS_ERRORS:
            if useless in line:
                return True
        return False

    def run_workflow(self, workflow):

        """Run a workflow and gather information about the runtime of each step."""
        command = ['cwltool']

        
        if  self.container == "singularity": #use singularity if the flag is set
            LoggingWrapper.warning("Using singularity container, memory usage will not be calculated.")
            command.append('--singularity')

       
        command.extend(['--disable-color', '--timestamps', '--outdir', self.outdir, workflow, self.input_yaml_path])  #add the required option in cwltool to disable color and timestamps to enable benchmarking
        steps = self.extract_steps_from_cwl(workflow)
       
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8', check=True)  #run the workflow
        if (self.verbose):
            print(result.stdout)
        output_lines = result.stdout.split('\n')
        success_pattern = re.compile(r'\[job (.+)\] completed success') #pattern to match the success of a step
        fail_pattern = re.compile(r'\[job (.+)\] completed permanentFail') #pattern to match the failure of a step
        success_steps = set()
        step_results = [{"step": step, "status": "unknown", "time": "unknown", "memory": "unknown", "warnings": "unknown", "errors": "unknown"} for step in steps]
        for line in output_lines: # iterate over the output of the workflow and find which steps were executed successfully
            if success_pattern.search(line):
                success_steps.add(success_pattern.search(line).group(1))
            elif fail_pattern.search(line):
                for entry in step_results:
                    if entry["step"] == fail_pattern.search(line).group(1):
                        entry["status"] = "fail"
                        entry["time"] = "unknown"
                        entry["memory"] = "unknown"
                        entry["warnings"] = "unknown"
                        entry["errors"] = "unknown"

    
        for step in success_steps: # iterate over the output of the workflow and find the benchmark values for each step
            max_memory_step = "unknown"
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
            for entry in step_results: # store the benchmark values for each successfully executed step
                if entry["step"] == step:
                    entry["status"] = "success"
                    entry["time"] = execution_time_step
                    entry["memory"] = max_memory_step
                    entry["warnings"] = warnings_step
                    entry["errors"] = errors_step

        workflow_status  =  "success"
        for entry in step_results: # check if the workflow was executed successfully
            if entry["status"] == "fail" or entry["status"] == "unknown":
                workflow_status = "fail"
                break

        self.workflow_benchmark_result = {
            "n_steps": len(steps),
            "status": workflow_status,
            "steps": step_results,
        }



    
    def calc_value(self, name):
        """Calculate the benchmark values for the given benchmark."""
        if name == "status":
            value = 0
            for entry in self.workflow_benchmark_result["steps"]:
                if entry[name] != "unknown":
                    value = value + 1
                else:
                    return "unknown"
        elif name == "time":
            value = 0
            for entry in self.workflow_benchmark_result["steps"]:
                if entry[name] != "unknown":
                    value = value + entry["time"]
                else:
                    return "unknown"
        elif name == "memory":
            value = 0
            for entry in self.workflow_benchmark_result["steps"]:
                if entry[name] != "unknown":
                    # remove last 3 characters from string (MiB, GiB, etc.)
                    value = max(value, int (entry["memory"].rstrip(entry["memory"][-3:])))
                else:
                    return "unknown"
        elif name == "warnings":
            value = 0
            for entry in self.workflow_benchmark_result["steps"]:
                if entry[name] != "unknown":
                    value = value + len(entry["warnings"])
                else:
                    return "unknown"
        elif name == "errors":
            value = 0
            for entry in self.workflow_benchmark_result["steps"]:
                if entry[name] != "unknown":
                    value = value + len(entry["errors"])
                else:
                    return "unknown"
        return value
    
    def calc_desirability(self, name, value):
        """Calculate the desirability for the given benchmark value."""
        if name == "status":
            if value == "success":
                return 1
            else:
                return 0
        elif name == "errors":
            if len(value) == 0:
                return 1
            else:
                return 0    
        elif name == "time":
            if value == "unknown":
                return 0
            bins = self.EXECUTION_TIME_DESIRABILITY_BINS
            count = value
        elif name == "memory":
            if value == "unknown":
                return 0
            bins = self.MAX_MEMORY_DESIRABILITY_BINS
            count = int(value.rstrip(value[-3:]))
        elif name == "warnings":
            bins = self.WARNINGS_DESIRABILITY_BINS
            count = len(value)
           
        for bin in bins.keys():
            if "-" in bin:
                if count <= int(bin.split("-")[1]):
                    return bins[bin]
        return 0

    
    def get_benchmark(self, name):
        """Get a benchmark from the benchmark data."""
        benchmark = []
        for entry in self.workflow_benchmark_result["steps"]:
                step_benchmark = {
                    "description": entry["step"],
                    "value": entry[name],
                    "desirability_value": 0 if entry["status"] == "fail" or entry["status"] == "unknown" else self.calc_desirability(name, entry[name])
                }
                benchmark.append(step_benchmark)
        return benchmark

    def run_workflows(self):
        """Run the workflows in the given directory and store the results in a json file."""
        success_workflows = []
        failed_workflows = []
        workflows_benchmarks = []
       
        for workflow_path in self.workflows:  # iterate over the workflows and execute them
            workflow_name = Path(workflow_path).name
            LoggingWrapper.info("Benchmarking " + workflow_name + "...", color="green")
            self.run_workflow(workflow_path)
            if self.workflow_benchmark_result["status"] == "fail": # check if the workflow was executed successfully
                LoggingWrapper.error(workflow_name + " failed")
                failed_workflows.append(workflow_name)
            else:
                LoggingWrapper.info(workflow_name + " finished successfully.", color="green")
                success_workflows.append(workflow_name)
            LoggingWrapper.info("Benchmarking " + workflow_name + " completed.", color="green")
            # store the benchmark results for each workflow in a json file
            all_workflow_data = {
            "workflowName": "",
            "executor": "cwltool " + self.version,
            "runID": "39eddf71ea1700672984653",
            "inputs":{key: {"filename": self.input[key]["filename"]} for key in self.input},
            "benchmarks": []
            }
           
            all_workflow_data["workflowName"] = workflow_name

            all_workflow_data["benchmarks"].append({"benchmark_long_title": "Status",
                                                    "benchmark_description": "Status for each step in the workflow",
                                                    "benchmark_title": "Status",
                                                    "benchmark_unit": "status",
                                                    "values": str(self.calc_value("status")) + "/" + str(self.workflow_benchmark_result["n_steps"]),
                                                    "steps": self.get_benchmark("status"),
                                                    })
            all_workflow_data["benchmarks"].append({
                                                    "benchmark_long_title": "Execution time",
                                                    "benchmark_description": "Execution time for each step in the workflow",
                                                    "benchmark_title": "Execution time",
                                                    "benchmark_unit": "seconds",
                                                    "values": "unknown" if self.workflow_benchmark_result["status"] == "fail" else self.calc_value("time"),
                                                    "steps": self.get_benchmark("time"),
                                                    })
            all_workflow_data["benchmarks"].append({"benchmark_long_title": "Memory usage",
                                                    "benchmark_description": "Memory usage for each step in the workflow",
                                                    "benchmark_title": "Memory usage",
                                                    "benchmark_unit": "megabytes",
                                                    "values": "unknown" if self.workflow_benchmark_result["status"] == "fail" else self.calc_value("memory"),
                                                    "steps": self.get_benchmark("memory"),
                                                    })
            all_workflow_data["benchmarks"].append({"benchmark_long_title": "Warnings",
                                                    "benchmark_description": "Warnings for each step in the workflow",
                                                    "benchmark_title": "Warnings",
                                                    "benchmark_unit": "warnings",
                                                    "values": "unknown" if self.workflow_benchmark_result["status"] == "fail" else self.calc_value("warnings"),
                                                    "steps": self.get_benchmark("warnings"),
                                                    })
            all_workflow_data["benchmarks"].append({"benchmark_long_title": "Errors",
                                                    "benchmark_description": "Errors for each step in the workflow",
                                                    "benchmark_title": "Errors",
                                                    "benchmark_unit": "errors",
                                                    "values": "unknown" if self.workflow_benchmark_result["status"] == "fail" else self.calc_value("errors"),
                                                    "steps": self.get_benchmark("errors"),
                                                    })

            workflows_benchmarks.append(all_workflow_data)


        with open(os.path.join(self.outdir, "benchmarks.json"), 'w') as f:
            json.dump(workflows_benchmarks, f, indent=3)
            LoggingWrapper.info("Benchmark results stored in " + os.path.join(self.outdir, "benchmarks.json"), color="green")    
        LoggingWrapper.info("Benchmarking completed.", color="green", bold=True)
        LoggingWrapper.info("Total number of workflows benchmarked: " + str(len(self.workflows)))
        LoggingWrapper.info("Number of workflows failed: " + str(len(failed_workflows)))
        LoggingWrapper.info("Number of workflows finished successfully: " + str(len(success_workflows)))
        LoggingWrapper.info("Successful workflows: " + ", ".join(success_workflows))
        LoggingWrapper.info("Failed workflows: " + ", ".join(failed_workflows))
            