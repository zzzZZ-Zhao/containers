#!/bin/sh

conda run --no-capture-output -n comet-ms comet -p
ls /data
cp /data/comet.params.new /cwl/example1/comet.params
#cwl-runner /cwl/example1/workflow.cwl --input2 /cwl/example1/up00000062.fasta --input1 /cwl/example1/2021-10-8_Ecoli.mzML