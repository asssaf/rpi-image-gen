#!/usr/bin/env bash

set -euxo pipefail

/rpi-image-gen/build.sh "$@" && exit 0

echo "Build failed"

# useful in case of "genimage error" (might also want to run genimage with a higher --loglevel)
cat /rpi-image-gen/work/custom/artefacts/genimage.cfg
