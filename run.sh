#!/bin/bash -e
IMG=the-ultimate-videogame:build
mkdir -p .cache/docker-.cache
docker run --user "`id -u`:`id -g`" --rm -it \
    -v "$PWD:/mount"  \
    -v "$PWD/.cache/docker-.cache:/.cache" \
    -w '/mount' \
    --entrypoint bash --hostname videogame \
    $IMG "$@"
