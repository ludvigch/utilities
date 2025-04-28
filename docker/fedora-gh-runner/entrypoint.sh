#!/bin/bash
set -e

# Configure the runner if not already configured
if [ ! -d ".runner" ]; then
  ./config.sh --url "${GITHUB_URL}" --token "${GITHUB_TOKEN}" --unattended --replace
fi

# Run the runner
./run.sh