#!/bin/sh
 
 conda run --no-capture-output -n comet-ms which comet

 ./print_test_result.sh comet $?
#    if [ $? -eq 0 ]; then
#       echo "comet installed."
#     else
#       RED='\033[0;31m'
#       NC='\033[0m' # No Color
#       echo -e "[${RED}ERROR${NC}]: comet not installed."
#    fi