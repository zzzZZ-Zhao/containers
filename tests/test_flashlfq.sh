#!/bin/sh
 
 conda run --no-capture-output -n flashlfq FlashLFQ --version

 ./print_test_result.sh FlashLFQ $?
  #  if [ $? -eq 0 ]; then
  #     echo "FlashLFQ installed."
  #   else
  #     RED='\033[0;31m'
  #     NC='\033[0m' # No Color
  #     echo -e "[${RED}ERROR${NC}]: FlashLFQ not installed."
  #  fi