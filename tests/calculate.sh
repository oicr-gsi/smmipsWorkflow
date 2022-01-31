#!/bin/bash
set -o nounset
set -o errexit
set -o pipefail

cd $1

find . -regex '.*\.json$' -printf "%f " -exec sh -c "cat {} | md5sum" \;

