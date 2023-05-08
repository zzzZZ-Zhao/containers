#!/bin/sh
 
 conda run --no-capture-output -n flashlfq FlashLFQ --version

 #./print_test_result.sh FlashLFQ $?
  
  
  
TOOL=FlashLFQ
ERROR=$?

if [ $ERROR -eq 0 ]; then
    echo "${TOOL} installed successfully."
else
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    echo -e "[${RED}ERROR${NC}]: ${TOOL} installation failed."
fi