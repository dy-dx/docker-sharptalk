#!/bin/sh
set -e

tag="sharptalk:latest"

docker build -f Dockerfile -t "$tag" .

msg=${1:-"hello world"}

# echo "$msg" | ./docker-run.sh > asdf.pcm && \
#   ffmpeg -y -f s16le -ar 11025 -ac 1 -i asdf.pcm asdf.wav && \
#   play asdf.wav

echo "$msg" | tag="$tag" ./docker-run.sh | play -b 16 -e signed-integer -L -r 11025 -c 1 -t raw -
