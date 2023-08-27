#!/bin/bash
set -e

conda run -n protxml2idlist xmllint --xpath "//*[local-name()='protein']/@protein_name" $1 | cut -d '|' -f2 > id_list.txt