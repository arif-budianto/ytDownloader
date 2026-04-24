cask "yt-downloader" do
  version "3.20.3"
  sha256 "e9b210fca23dfe401d09cf7d385d32a17b67a877d8f4187d1ed65837c13a0a05"

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
