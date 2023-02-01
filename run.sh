#!/bin/bash -e
IMG=the-ultimate-videogame:build
docker run --user "`id -u`:`id -g`" --rm -it -v "$PWD:/mount" -v "/mount" \
    --entrypoint bash --hostname videogame \
    $IMG "$@"
