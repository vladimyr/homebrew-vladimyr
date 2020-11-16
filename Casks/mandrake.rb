cask "mandrake" do
  version "3.3"
  sha256 "55d137f32c5f34200b05e26b601963f2bcefc0332a4c80e62af6131bdd3cb4c7"

  url "https://sveinbjorn.org/files/software/mandrake/ManDrake-#{version}.zip"
  appcast "https://sveinbjorn.org/files/appcasts/ManDrakeAppcast.xml"
  name "ManDrake"
  homepage "https://sveinbjorn.org/mandrake"

  auto_updates true

  app "ManDrake.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.sveinbjorn.mandrake.sfl2",
    "~/Library/Caches/org.sveinbjorn.ManDrake",
    "~/Library/Preferences/org.sveinbjorn.ManDrake.plist",
    "~/Library/Saved Application State/org.sveinbjorn.ManDrake.savedState",
  ]
end
