cask 'hopper-disassembler' do
  version '4.5.22-demo'
  sha256 '6b99f7d185fa6e09147fad4ab1ef8a8567ebf89ed2c598164a022ceb85f3450b'

  # d2ap6ypl1xbe4k.cloudfront.net was verified as official when first introduced to the cask
  url "https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-#{version}.dmg"
  appcast 'https://www.hopperapp.com/rss/html_changelog.php'
  name 'Hopper Disassembler'
  homepage 'https://www.hopperapp.com/'

  auto_updates true

  app "Hopper Disassembler v#{version.major}.app"
  binary "#{appdir}/Hopper Disassembler v#{version.major}.app/Contents/MacOS/hopper"

  zap trash: [
               '~/Library/Application Support/Hopper',
               "~/Library/Application Support/Hopper Disassembler v#{version.major}",	
               '~/Library/Caches/com.apple.helpd/Generated/com.cryptic-apps.hopper-web-*.help*',
               "~/Library/Caches/com.cryptic-apps.hopper-web-#{version.major}",	
               "~/Library/Preferences/com.cryptic-apps.hopper-web-#{version.major}.plist",	
               "~/Library/Saved Application State/com.cryptic-apps.hopper-web-#{version.major}.savedState",
             ]
end
