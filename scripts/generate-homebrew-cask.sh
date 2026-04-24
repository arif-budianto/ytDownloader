#!/bin/bash

set -euo pipefail

VERSION="${1:-}"
SHA256="${2:-}"

if [ -z "$VERSION" ] || [ -z "$SHA256" ]; then
    echo "Usage: $0 <version> <sha256>" >&2
    exit 1
fi

cat > Casks/ytdownloader.rb <<CASK
cask "ytdownloader" do
  version "$VERSION"
  sha256 "$SHA256"

  url "https://github.com/arif-budianto/ytDownloader/releases/download/v#{version}/YTDownloader_Mac_arm64.dmg",
      verified: "github.com/arif-budianto/ytDownloader/"
  name "YTDownloader"
  desc "Download videos and audios from YouTube and other sites"
  homepage "https://github.com/arif-budianto/ytDownloader"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  app "YTDownloader.app"

  zap trash: [
    "~/Library/Application Support/ytdownloader",
    "~/Library/Caches/io.github.arifbudianto.ytdn",
    "~/Library/Logs/YTDownloader",
    "~/Library/Preferences/io.github.arifbudianto.ytdn.plist",
  ]
end
CASK
