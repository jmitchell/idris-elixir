#!/bin/bash

set -e

TEST_INPUT_DIR="./test/inputs"
TEST="${TEST_INPUT_DIR}/$1"
TMP_DIR="./tmp"
TMP_FILE_PREFIX="${TMP_DIR}/$(basename ${TEST})"

mkdir -p "${TMP_DIR}"
idris "${TEST}.idr" -o "${TMP_FILE_PREFIX}"
mv "${TEST}.ibc" "${TMP_FILE_PREFIX}.ibc"
stack build
./.stack-work/install/x86_64-linux/lts-7.16/8.0.1/bin/idris-elixir "${TMP_FILE_PREFIX}.ibc" -o "${TMP_FILE_PREFIX}.ex"

echo ""
echo "Generated output"
echo "================"
cat "${TMP_FILE_PREFIX}.ex"
rm -rf "${TMP_DIR}"
