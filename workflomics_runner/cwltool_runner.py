from cwltool_wrapper import CWLToolWrapper
import subprocess
from pathlib import Path
import re
import datetime
import json
from loggingwrapper import LoggingWrapper

class CWLToolRunner(CWLToolWrapper):

    def __init__(self, args):
       
        super().__init__(args)


    def run_workflow(self, workflow):
        command = ['cwltool']

        if  self.container == "singularity":
            command.append('--singularity')

        command.extend([ '--outdir', self.outdir, self.workflow, self.input])
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding='utf-8', check=True)  #run the workflow
        print(result.stdout)
        print(result.stderr)



    def run_workflows(self):
        '''Run the workflows in the given directory'''

        for workflow_path in self.workflow:
            self.run_workflow(workflow_path)