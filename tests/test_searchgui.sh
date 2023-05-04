#!/bin/sh
 
 conda run --no-capture-output -n searchgui which searchgui

  ./print_test_result.sh searchgui $?
  #  if [ $? -eq 0 ]; then
  #     echo "maxquant installed."
  #   else
  #     RED='\033[0;31m'
  #     NC='\033[0m' # No Color
  #     echo -e "[${RED}ERROR${NC}]: maxquant not installed."
  #  fi