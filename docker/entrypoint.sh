#!/usr/bin/env bash

set -eux

/rpi-image-gen/build.sh "$@" && exit 0

echo "Build failed"
find /rpi-image-gen/work