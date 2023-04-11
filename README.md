
# containers
Containers to package the required sofware to execute CWL. The container will include the following:

<ol>
<li>raw2mzdb </li>
<li>mzdb2mgf (not in bio.tools). Both of the above tools are available in mzdb-tools (https://github.com/mzdb/mzdb4s/releases/download/0.4.3/mzdbtools_0.4.3_linux_x64.zip)</li>
<li> create_decoy_database (part of SearchGUI. Available on bioconda)</li>
<li>prepare_searchgui(part of SearchGUI tool. Available on bioconda)</li>
<li>run_searchgui(part of SearchGUI tool. Available on bioconda)</li>
<li>config_proline (This is not a tool. It is a set of "sed commands.).</li>
<li>exp_design_proline(This is not a tool. It is a set of "sed commands.)</li>
<li>run_proline ( Avaliloble on: https://github.com/profiproteomics/proline-cli/releases/download/0.2.0-SNAPSHOT-2019-10-04/proline-cli-0.2.0-SNAPSHOT-bin.zip)</li>
<li> run_polystest(Not in bio.tools. Available on bioconda)</li>
<li>convert_polystest (Not in bio.tools.Available on bioconda. However, run_polystest and convert_polystest use different versions. For now, I will istall the newer, i.e. 1.2.2)</li>
<li>sdrf-pipelines (Available on bioconda)</li>
<li>normalyzerde (Available on bioconda)</li>
<li>maxquant (Available on bioconda)</li>
<li>raw2mzml (On bio.tools with name "ThermoRawFileParser". Available on bioconda)</li>
<li>run_peptideshaker (part of peptide-shaker tool. Available on bioconda</li>
<li>peptideshaker_report (part of peptide-shaker tool. Available on bioconda)</li>
<li>flashlfq (Available on bioconda.)</li>
<li>msqrob (Available on bioconda.)</li>
<li>comet (Available on bioconda)</li>
<li>peptideprophet (part of tpp tool. Available on bioconda)</li>
<li>protienprophet (part of tpp tool. Available on bioconda)</li>
<li>stpeter (part of tpp tool. Available on bioconda)</li>
<li>proxml2csv(An R script)</li>
<li>mergeoutput(An R script)</li>
<li>rots(Available on bioconda)</li>
</ol>