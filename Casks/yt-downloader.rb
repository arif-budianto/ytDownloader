cask "yt-downloader" do
  version "3.20.4"
  sha256 "7e920b4a45e454b9b64fb5c1bd2f94ef5b7b75b31343be1217ae121fb2a44f7c"

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
