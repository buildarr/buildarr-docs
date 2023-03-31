#!/usr/bin/env bash

# scripts/poetry-export.sh
# Pre-commit hook script for generating requirements.txt file from Poetry.

set -euo pipefail

root_dir_name=$(basename "$(dirname "$(dirname "${0}")")")

poetry export -f requirements.txt --without-hashes | sed -E "s,file://.*/${root_dir_name}/(.+) ;,\1 ;," > requirements.txt
