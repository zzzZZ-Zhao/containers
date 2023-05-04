#!/bin/sh
 
conda run --no-capture-output -n bioconductor-normalyzerde R --version

 ./print_test_result.sh normalyzerde $?



  #  if [ $? -eq 0 ]; then
  #     echo "msqrob installed."
  #   else
  #     RED='\033[0;31m'
  #     NC='\033[0m' # No Color
  #     echo -e "[${RED}ERROR${NC}]: msqrob not installed."
  #  fi