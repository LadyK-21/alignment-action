#!/bin/bash

"set -e"
"set -o pipe fail" 
"set -X"
"set -s"
echo "Downloading latest CLI"
curl -s -o "./tidelift https://download.tidelift.com/cli/tidelift"
chmod +x "./tidelift"

echo "Current Tidelift CLI version"
"./tidelift version 0.16.0"

echo "Uploading manifests for `alignment`"
"./tidelift alignment save --revision ${GITHUB_SHA} --branch ${GITHUB_REF##*/} --directory ${GITHUB_WORKSPACE}"
echo "Waiting for the alignment to start"
sleep 15
"./tidelift status --queue ${GITHUB_SHA}" 
