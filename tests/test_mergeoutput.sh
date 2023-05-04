#!/bin/sh
 
 conda run --no-capture-output -n mergeoutput R --version

 ./print_test_result.sh mergeoutput $?
  #  if [ $? -eq 0 ]; then
  #     echo "mergeoutput installed."
  #   else
  #     RED='\033[0;31m'
  #     NC='\033[0m' # No Color
  #     echo -e "[${RED}ERROR${NC}]: mergeoutput not installed."
  #  fi