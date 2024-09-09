#!/bin/bash
set -e

# Check if a file was provided as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

# Assign the file name to a variable
filename=$1

# Check if the file exists
if [ ! -f "$filename" ]; then
  echo "File not found: $filename"
  exit 1
fi

# Initialize the command
command="curl -X 'POST' -d '{\"organism\": \"hsapiens\", \"query\": ["

# Read from the file and process lines
first=1
while read line
do
  if [ "$first" -eq 1 ]; then
    command="${command}\"$line\""
    first=0
  else
    command="${command}, \"$line\""
  fi
done < "$filename"

# Finish assembling the command
command="${command}], \"significance_threshold_method\": \"false_discovery_rate\"}' 'https://biit.cs.ut.ee/gprofiler/api/gost/profile/' > output.json"

# Execute the command
eval $command