from pathlib import Path
import yaml
import subprocess
from loggingwrapper import LoggingWrapper


class CWLToolWrapper():
    ''' This is the main class for the workflomics_runner application. It contains the common methods for the benchmark and run commands.'''


    def __init__(self, args):
        if args.singularity:
            self.container = "singularity"
        self.outdir = args.outdir
        self.workflow = args.workflow
        self.input_yaml_path = args.input
        if all(Path(workflow).is_dir() for workflow in args.workflow):
            self.workflow = [str(file) for file in Path(args.workflow[0]).glob('*.cwl')]
        self.version = self.check_cwltool()
        self.input = self.update_input_yaml(self.input_yaml_path)



    def check_cwltool(self):
        '''Check if cwltool is installed and return the version'''
        try:
            result = subprocess.run(['cwltool', '--version'], capture_output=True, text=True)
            version = result.stdout.strip().split()[-1]
            print(f"Using cwltool {version}")
        except FileNotFoundError:
            print("cwltool is not installed.")
        return version

    def update_input_yaml(self, input_yaml_path):
        '''Update the input yaml file with the paths to the input files'''
        inputs = {}
        with open(input_yaml_path, 'r') as file:
            input_data = yaml.safe_load(file)

        for key, value in input_data.items():
            if key.startswith('input'):
                print(f"The path for {key} is {value['path']}. Do you want to change it? (y/n)")
                answer = input()
                if answer == 'y':
                    new_path = input(f"Enter the path for {key}: ")
                    value['path'] = new_path.strip()
                    inputs[key] = {"filename": Path(value['path']).name}
                else:
                    inputs[key] = {"filename": Path(value['path']).name}
        with open(input_yaml_path, 'w') as file:
            documents = yaml.dump(input_data, file)
        return inputs

    def extract_steps_from_cwl(self, workflow_file):
        '''Extract the step names from the cwl workflow file'''
        with open(workflow_file, 'r') as file:
            data = yaml.safe_load(file)
        steps = []
        for step_name in data.get('steps', {}):
            steps.append(step_name)
        return steps

    