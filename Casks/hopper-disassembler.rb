cask "hopper-disassembler" do
  version "4.7.7-demo"
  sha256 "b80789775f4151c9149790f96a09c20e4853b20cd8dcb5a91ba5037f80b56e70"

  url "https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-#{version}.dmg",
      verified: "d2ap6ypl1xbe4k.cloudfront.net/"
  name "Hopper Disassembler"
  homepage "https://www.hopperapp.com/"

  livecheck do
    url "https://www.hopperapp.com/HopperWeb/appcast_v#{version.major}.php?Demo=true"
    strategy :sparkle
  end

  auto_updates true

  app "Hopper Disassembler v#{version.major}.app"
  binary "#{appdir}/Hopper Disassembler v#{version.major}.app/Contents/MacOS/hopper"

  zap trash: [
    "~/Library/Application Support/Hopper",
    "~/Library/Application Support/Hopper Disassembler v#{version.major}",
    "~/Library/Caches/com.apple.helpd/Generated/com.cryptic-apps.hopper-web-*.help*",
    "~/Library/Caches/com.cryptic-apps.hopper-web-#{version.major}",
    "~/Library/Preferences/com.cryptic-apps.hopper-web-#{version.major}.plist",
    "~/Library/Saved Application State/com.cryptic-apps.hopper-web-#{version.major}.savedState",
  ]
end
