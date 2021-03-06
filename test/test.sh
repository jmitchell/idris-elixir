#!/bin/bash

set -e

TEST_INPUT_DIR="./test/inputs"
TEST="${TEST_INPUT_DIR}/$1"
TMP_DIR="./tmp"
TMP_FILE_PREFIX="${TMP_DIR}/$(basename ${TEST})"
STACK_BIN="./.stack-work/install/x86_64-linux/lts-7.17/8.0.1/bin"

rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

"${STACK_BIN}/idris" "${TEST}.idr" -o "${TMP_FILE_PREFIX}"
mv "${TEST}.ibc" "${TMP_FILE_PREFIX}.ibc"
stack build
"${STACK_BIN}/idris-elixir" "${TMP_FILE_PREFIX}.ibc" -o "${TMP_FILE_PREFIX}.exs"
elixir "${TMP_FILE_PREFIX}.exs"
