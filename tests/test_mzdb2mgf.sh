#!/bin/sh
 
which mzdb2mgf

 ./print_test_result.sh mzdb2mgf $?



TOOL=mzdb2mgf
ERROR=$?

if [ $ERROR -eq 0 ]; then
    echo "${TOOL} installed successfully."
else
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    echo -e "[${RED}ERROR${NC}]: ${TOOL} installation failed."
fi