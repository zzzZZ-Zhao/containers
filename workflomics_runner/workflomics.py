import subprocess
import argparse
import yaml
import re
import json
import datetime
from pathlib import Path
from loggingwrapper import LoggingWrapper

from cwltool_runtime_benchmark import CWLToolRuntimeBenchmark
from cwltool_runner import CWLToolRunner


def add_benchmark_args(parser):
    """Add the arguments for the benchmark command."""
    parser.add_argument('--singularity', action='store_true', help='Use singularity instead of docker.')
    parser.add_argument('-o','--outdir', required=True, help='Path to the output directory to store the results.')
    parser.add_argument('-w','--workflow', nargs='+', required=True, help='Path to the workflows directory or a list of workflows.')
    parser.add_argument('-v', '--verbose', action='store_true', help='Print the output of the cwltool command.')
    parser.add_argument('-i','--input', required=True, help='Path to the input yaml file.')

def add_run_args(parser):
    """Add the arguments for the run command."""
    parser.add_argument('--singularity', action='store_true', help='Use singularity instead of docker.')
    parser.add_argument('-o','--outdir', required=True, help='Path to the output directory to store the results.')
    parser.add_argument('-w','--workflow', nargs='+', required=True, help='Path to the workflows directory or a list of workflows.')
    parser.add_argument('-v', '--verbose', action='store_true', help='Print the output of the cwltool command.')
    parser.add_argument('-i','--input', required=True, help='Path to the input yaml file.')
   

if __name__ == '__main__':
    """Main entry point for the workflomics_runner application."""

    LoggingWrapper.info("Starting workflomics_runner...", color="green", bold=True)

    parser = argparse.ArgumentParser(description='Wrapper for cwltool command.')
    # Adding subparsers for the benchmark and run commands
    subparcers = parser.add_subparsers(dest='subcommand', help='Subcommands.')
    parser_benchmark = subparcers.add_parser('benchmark', help='Run the benchmark.')
    parser_run = subparcers.add_parser('run', help='Run the workflow.')

    add_benchmark_args(parser_benchmark)
    add_run_args(parser_run)
    args = parser.parse_args()

    
    if (args.subcommand == "benchmark"):
        LoggingWrapper.info("Benchmarking Workflows...", color="green")
        op = CWLToolRuntimeBenchmark(args)
    elif (args.subcommand == "run"):
        op = CWLToolRunner(args)    

    op.run_workflows()

