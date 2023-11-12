#!/usr/bin/env bash

# scripts/poetry-export.sh
# Pre-commit hook script for generating requirements.txt file from Poetry.

set -euo pipefail

root_dir_name=$(basename "$(dirname "$(dirname "${0}")")")

if ! which poetry > /dev/null 2>&1
then
    python3 -m pip install "poetry==1.7.0"
fi

poetry export -f requirements.txt --without-hashes | sed -E "s,^[^ \t]+ @ file://.*/${root_dir_name}/(.+) ;,\1 ;," > requirements.txt
