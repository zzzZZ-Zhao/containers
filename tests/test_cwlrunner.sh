#!/bin/sh
 
cwl-runner --version

./print_test_result.sh cwl-runner $?
  #  if [ $? -eq 0 ]; then
  #     echo "cwl-runner installed."
  #   else
  #     RED='\033[0;31m'
  #     NC='\033[0m' # No Color
  #     echo -e "[${RED}ERROR${NC}]: cwl-runner not installed."
  #  fi