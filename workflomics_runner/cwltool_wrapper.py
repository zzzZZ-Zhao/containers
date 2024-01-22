from pathlib import Path
import yaml
import subprocess
from loggingwrapper import LoggingWrapper


class CWLToolWrapper():


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
        try:
            result = subprocess.run(['cwltool', '--version'], capture_output=True, text=True)
            version = result.stdout.strip().split()[-1]
            print(f"Using cwltool {version}")
        except FileNotFoundError:
            print("cwltool is not installed.")
        return version

    def update_input_yaml(self, input_yaml_path):
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

    def extract_steps_from_cwl(self, workflow_file):
        with open(workflow_file, 'r') as file:
            data = yaml.safe_load(file)
        steps = []
        for step_name in data.get('steps', {}):
            steps.append(step_name)
        return steps

    