# Workflow exploration use cases / scenarios


Five scenarios used to demonstrate usage of the tools currently available/annotated within the domain.

All workflows require at least 2 inputs (a Mass spectrum and a FASTA file) available at https://github.com/Workflomics/containers/tree/main/data/inputs/workflows/example1.


### No 1
Demonstrates a generic scenario.

 Inputs:
- Mass spectrum
- FASTA file
    
Outputs:

- protXML.


### No 2
Demonstrates a generic scenario including mzRecal tool.

 Inputs:
- Mass spectrum
- FASTA file
    
Outputs:

- protXML.

Constraints:
    - Use tool **mzRecal**

### No 3
Demonstrates a generic scenario including ontology files.

 Inputs:
- Mass spectrum
- FASTA file
    - Ontology (.obo) file
    - Gene Association File (.gaf) file
    
Outputs:

- text file.


### No 4
Demonstrates a generic scenario including gProfiler tool.

 Inputs:
- Mass spectrum
- FASTA file
    
Outputs:

- protXML.

Constraints:
    - Use tool **gProfiler**

### No 5
Demonstrates a generic scenario including X!Tandem tool.

 Inputs:
- Mass spectrum
- FASTA file
    
Outputs:

- protXML.

Constraints:
    - Use tool **X!Tandem**