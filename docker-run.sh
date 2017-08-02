#!/bin/sh

# Read from stdin if no arguments are provided
if [ "$1" ]; then
  msg="$1"
else
  msg="$(cat)"
fi

tag="${tag:-sharptalk:latest}"

# outputs 16-bit 11025Hz mono PCM data.

docker run --rm --net=none -e "WINEDEBUG=-all" "$tag" "$msg" 2> /dev/null
