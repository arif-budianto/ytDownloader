cask "ytdownloader" do
  version "3.20.2"
  sha256 "4c464fda00e85d24d7f8e41a849940358d4d5d1eb501f3eff98a5c1161c266d9"

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
