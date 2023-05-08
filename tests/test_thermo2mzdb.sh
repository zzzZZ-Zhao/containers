#!/bin/sh
 
which thermo2mzdb

 #./print_test_result.sh thermo2mzdb $?

TOOL=thermo2mzdb
ERROR=$?

if [ $ERROR -eq 0 ]; then
    echo "${TOOL} installed successfully."
else
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    echo -e "[${RED}ERROR${NC}]: ${TOOL} installation failed."
fi