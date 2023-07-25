#!/usr/bin/env sh
#
# Build docker image
#

set -eu

VAL_1=${1:-}
VAL_2=${2:-}
CLI_COMMAND=${CLI_COMMAND:-"kwil-cli"}

check_cli_installed() {
  if ! command -v "$CLI_COMMAND" > /dev/null 2>&1; then
    echo "Error: `${CLI_COMMAND}` is not installed or not in your PATH.  Download it from ${CLI_URL}."
    exit 1
  fi
}

getVals() {
    read -p "Enter val 1: " VAL_1
    read -p "Enter val 2: " VAL_2

    if [ -z "$VAL_1" ] || [ -z "$VAL_2" ]; then
        echo "Error: Empty values"
        exit 1
    fi
}

deploy() {
    check_cli_installed
    kwil-cli database deploy --path ./schemas/use_math.kf
}

add() {
    check_cli_installed
    getVals
    kwil-cli database execute --action add_vals --name math_db "val1:$VAL_1" "val2:$VAL_2"
}

sub() {
    check_cli_installed
    getVals
    kwil-cli database execute --action subtract --name math_db "val1:$VAL_1" "val2:$VAL_2"
}

mul() {
    check_cli_installed
    getVals
    kwil-cli database execute --action multiply --name math_db "val1:$VAL_1" "val2:$VAL_2"
}

div() {
    check_cli_installed
    getVals
    kwil-cli database execute --action divide --name math_db "val1:$VAL_1" "val2:$VAL_2"
}

test $# -eq 0 && (echo Availbale funcs:;echo; declare -F | awk '{print $3}'; exit 1)

$@ # Run the function passed as the first argument