#!/bin/bash

set -euo pipefail

FFMPEG_URL="https://evermeet.cx/ffmpeg/getrelease/zip"
FFPROBE_URL="https://evermeet.cx/ffmpeg/getrelease/ffprobe/zip"

if ! command -v curl > /dev/null 2>&1; then
    echo "curl not installed, please install it and try again"
    exit 1
fi

if ! command -v unzip > /dev/null 2>&1; then
    echo "unzip not installed, please install it and try again"
    exit 1
fi

tmp_dir=$(mktemp -d)
cleanup() {
    rm -rf "$tmp_dir"
}
trap cleanup EXIT

mkdir -p ffmpeg/bin

curl -L "$FFMPEG_URL" -o "$tmp_dir/ffmpeg.zip"
curl -L "$FFPROBE_URL" -o "$tmp_dir/ffprobe.zip"

unzip -o "$tmp_dir/ffmpeg.zip" -d "$tmp_dir/ffmpeg" > /dev/null
unzip -o "$tmp_dir/ffprobe.zip" -d "$tmp_dir/ffprobe" > /dev/null

cp "$tmp_dir/ffmpeg/ffmpeg" ffmpeg/bin/ffmpeg
cp "$tmp_dir/ffprobe/ffprobe" ffmpeg/bin/ffprobe

chmod +x ffmpeg/bin/ffmpeg
chmod +x ffmpeg/bin/ffprobe
