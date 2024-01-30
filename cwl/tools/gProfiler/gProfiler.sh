#!/bin/bash
set -e


# Construct the curl command
#curl -X 'POST' -d '{"organism": "hsapiens", "query": ['"$(cat "$1" | tr '\n' ',' | sed 's/,$//' | sed 's/,/","/g')"]}\' 'https://biit.cs.ut.ee/gprofiler/api/gost/profile/' > output.txt
awk ‘BEGIN {command="curl -X 'POST' -d '{\"organism\": \"hsapiens\", \"query\": ["}  (NR==1){command = command "\"" $1 "\""} (NR>1){command = command ", \"" $1 "\""} END {command = command "]}' 'https://biit.cs.ut.ee/gprofiler/api/gost/profile/' > output.txt" ; system(command)} $1

