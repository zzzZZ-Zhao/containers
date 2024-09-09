# Workflomics domain template

This domain template can be copied and used as a starting point for creating new domains in the Workflomics environment. These files are used by the [APE](https://ape-framework.readthedocs.io/en/latest) library within the Workflomics environment to generate workflows. The domain template contains the following files:

- `tools.json`: Contains the tool descriptions of the domain. See the [documentation](https://ape-framework.readthedocs.io/en/latest/docs/specifications/setup.html#tool-annotations) to learn more about `tools.json` file format.
- `config.json`: Contains the domain-specific parameters. See the [documentation](https://ape-framework.readthedocs.io/en/latest/docs/specifications/setup.html#configuration-file) to learn more about the configuration file.
- `constraints.json`: Contains the constraints for the domain. The file could be included in the `config.json` file, or linked from the `config.json` file (as in this template). See the [documentation](https://ape-framework.readthedocs.io/en/latest/docs/specifications/setup.html#configuration-file) to learn more about the constraints file format.