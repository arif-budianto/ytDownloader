#!/bin/bash

set -euo pipefail

NODE_VERSION="v22.22.1"
NODE_URL="https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz"
FFMPEG_URL="https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz"

if ! command -v curl > /dev/null 2>&1; then
    echo "curl not installed, please install it and try again"
    exit 1
fi

if ! command -v tar > /dev/null 2>&1; then
    echo "tar not installed, please install it and try again"
    exit 1
fi

tmp_dir=$(mktemp -d)
cleanup() {
    rm -rf "$tmp_dir"
}
trap cleanup EXIT

curl -L "$NODE_URL" -o "$tmp_dir/node.tar.xz"
tar -xf "$tmp_dir/node.tar.xz" -C "$tmp_dir"
cp "$tmp_dir"/node-*/bin/node ./node
chmod +x ./node

curl -L "$FFMPEG_URL" -o "$tmp_dir/ffmpeg.tar.xz"
tar -xf "$tmp_dir/ffmpeg.tar.xz" -C "$tmp_dir"

rm -rf ./ffmpeg
ffmpeg_dir=$(find "$tmp_dir" -maxdepth 1 -type d -name 'ffmpeg-*' | head -n 1)
mv "$ffmpeg_dir" ./ffmpeg

chmod +x ./ffmpeg/bin/ffmpeg
chmod +x ./ffmpeg/bin/ffprobe
if [ -f ./ffmpeg/bin/ffplay ]; then
    chmod +x ./ffmpeg/bin/ffplay
fi
