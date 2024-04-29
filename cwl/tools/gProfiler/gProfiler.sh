#!/bin/bash
set -e


# Construct the curl command
awk ‘BEGIN {command="curl -X 'POST' -d '{\"organism\": \"hsapiens\", \"query\": ["}  (NR==1){command = command "\"" $1 "\""} (NR>1){command = command ", \"" $1 "\""} END {command = command "]}' 'https://biit.cs.ut.ee/gprofiler/api/gost/profile/' > output.json" ; system(command)} $1

