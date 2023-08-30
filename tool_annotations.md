Wombat pipeline tools - Annotation quality

| **No.** | **Tool** | **in bio.tools** | **bio.tools annotations quality** | **in bioconda** | **external source** | **CWL file available?** | **version** |
| ------- | -------- | ---------------- | ------ | ---------- | ---------- | -------- | --------| 
| 1 | raw2mzdb | [raw2mzDB](https://bio.tools/raw2mzdb) | :white_check_mark: | :heavy_multiplication_x: | - | No | - |
| 2 | mzdb2mgf | :heavy_multiplication_x: | - | :heavy_multiplication_x: | [link](https://github.com/mzdb/mzdb4s/releases/download/0.4.3/mzdbtools_0.4.3_linux_x64.zip) | No | - |
| 3 | create_decoy_database | [SearchGUI](https://bio.tools/SearchGUI) (only 1 function is annotated) | :mag: | :ballot_box_with_check: | - | No | - |
| 4 | prepare_searchgui | [SearchGUI](https://bio.tools/SearchGUI) (only 1 function is annotated) | :mag: | :ballot_box_with_check: | - | No | - |
| 5 | run_searchgui | [SearchGUI](https://bio.tools/SearchGUI) | :white_check_mark: (assuming that this is the annotated command) | :ballot_box_with_check: | - | No | - |
| 6 | config_proline | [proline](https://bio.tools/proline) | :x: | :heavy_multiplication_x: | [link](https://github.com/profiproteomics/proline-cli/releases/download/0.2.0-SNAPSHOT-2019-10-04/proline-cli-0.2.0-SNAPSHOT-bin.zip) | No | - |
| 7 | exp_design_proline | [proline](https://bio.tools/proline) | :x: | :heavy_multiplication_x: | [link](https://github.com/profiproteomics/proline-cli/releases/download/0.2.0-SNAPSHOT-2019-10-04/proline-cli-0.2.0-SNAPSHOT-bin.zip) | No | - |
| 8 | run_proline | [proline](https://bio.tools/proline) | :x: | :heavy_multiplication_x: | [link](https://github.com/profiproteomics/proline-cli/releases/download/0.2.0-SNAPSHOT-2019-10-04/proline-cli-0.2.0-SNAPSHOT-bin.zip) | No | - |
| 9 | run_polytest | :heavy_multiplication_x: | - | :ballot_box_with_check: | - | No | - |
| 10 | convert_polytest | :heavy_multiplication_x: | - | :ballot_box_with_check:? | - | No | - |
| 11 | sdrf-pipelines  | [sdrf-pipelines](https://bio.tools/sdrf-pipelines) | :white_check_mark: (has 2 functions: **conversion, format validation**) | :ballot_box_with_check: | - | No | - |
| 12 | normalyzerde | [normalyzerde](https://bio.tools/:heavy_multiplication_x:rmalyzerde) | :x: | :ballot_box_with_check: | - | No | - |
| 13 | maxquant | [MaxQuant](https://bio.tools/maxquant) | :white_check_mark: | :ballot_box_with_check: | - | No | - |
| 14 | raw2mzml | [ThermoRawFileParser](https://bio.tools/ThermoRawFileParser) | :white_check_mark: | :ballot_box_with_check: | - | No | - |
| 15 | run_peptideshaker | [PeptideShaker](https://bio.tools/peptideshaker) or [Peptide-shaker](https://bio.tools/peptide-shaker) | :mag: (many I/O) | :ballot_box_with_check: | - | No | - |
| 16 | peptideshaker_report |[PeptideShaker](https://bio.tools/peptideshaker) | :mag: (many I/O) | :ballot_box_with_check: | - |
| 17 | flashlfq | [FlashLFQ](https://bio.tools/flashlfq) | :x: | :ballot_box_with_check: | - | No | - |
| 18 | msqrob | [MSqRob](https://bio.tools/msqrob) | :mag: (missing output format) | :ballot_box_with_check: | - | No | - |
| 19 | comet | [Comet](https://bio.tools/comet) | :white_check_mark: | :ballot_box_with_check: | - | Yes | 2023.01 rev. 2 |
| 20 | peptideprophet | [PeptideProphet](https://bio.tools/peptideprophet) | :white_check_mark: | :ballot_box_with_check: | In TPP |Yes | TPP v6.3.2 Arcus, Build 202308252102-exported (Linux-x86_64) |
| 21 | protienprophet | [ProteinProphet](https://bio.tools/proteinprophet) | :white_check_mark: | :ballot_box_with_check: | In TPP |Yes | TPP v6.3.2 Arcus, Build 202308252102-exported (Linux-x86_64) |
| 22 | stpeter | [StPeter](https://bio.tools/stpeter) | :white_check_mark: | :ballot_box_with_check: | In TPP | Yes | TPP v6.3.2 Arcus, Build 202308252102-exported (Linux-x86_64) |
| 23 | proxml2csv | :heavy_multiplication_x: | - |  :heavy_multiplication_x: | - | No | - |
| 24 | mergeoutput | :heavy_multiplication_x: | - |  :heavy_multiplication_x: | - | No | - |
| 25 | rots | :heavy_multiplication_x: | - |  :heavy_multiplication_x: | - | No | - |
| 26 | GOEnrichment | [GOEnrichment](https://bio.tools/GOEnrichment) | :white_check_mark: |  :ballot_box_with_check: | https://github.com/DanFaria/GOEnrichment | Yes | 2.0 |
| 27 | XTandem | - | - | - | https://www.thegpm.org/tandem | Yes | - |
| 28 | g:Profiler | [gProfiler](https://bio.tools/gprofiler) | :white_check_mark: | - | https://biit.cs.ut.ee/gprofiler/gost | Yes | - |



:white_check_mark: - good quality annotation

:mag: - annotation partially available (improvement needed)

:x: - bad annotation (missing inputs and/or outputs)

<br/>

:ballot_box_with_check: - resource available

:heavy_multiplication_x: - resource **not** available
