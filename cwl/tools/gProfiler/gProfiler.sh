#!/bin/bash
set -e


# Construct the curl command
curl -X 'POST' -d '{"organism": "hsapiens", "query": ['"$(cat "$1" | tr '\n' ',' | sed 's/,$//' | sed 's/,/","/g')"]}\' 'https://biit.cs.ut.ee/gprofiler/api/gost/profile/' > output.txt
