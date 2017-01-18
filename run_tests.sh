#!/bin/bash

TESTS=("hello")

for t in ${TESTS}; do
    ./test/test.sh "${t}"
done
