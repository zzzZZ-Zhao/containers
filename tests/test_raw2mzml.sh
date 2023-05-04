#!/bin/sh
 
conda run --no-capture-output -n raw2mzml thermorawfileparser --version

 ./print_test_result.sh raw2mzml $?




  #  if [ $? -eq 0 ]; then
  #     echo "msqrob installed."
  #   else
  #     RED='\033[0;31m'
  #     NC='\033[0m' # No Color
  #     echo -e "[${RED}ERROR${NC}]: msqrob not installed."
  #  fi