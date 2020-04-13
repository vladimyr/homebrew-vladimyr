cask 'manopen' do
  version '2.6'
  sha256 '7b383ca493b0b360bb58e65f7e7ce0a92383ff38c5221cc410eaf03f1117a958'

  url "https://web.archive.org/web/20190910122314/http://www.clindberg.org/projects/ManOpen-#{version}.dmg"
  name 'ManOpen'
  homepage 'https://web.archive.org/web/20190910122314/http://www.clindberg.org/projects/manopen.html'

  app 'ManOpen.app'
  binary 'openman'
  manpage 'openman.1'

  zap trash: [
               '~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.clindberg.manopen.sfl2',
               '~/Library/Preferences/org.clindberg.ManOpen.plist',
               '~/Library/Saved Application State/org.clindberg.ManOpen.savedState',
             ]
end
