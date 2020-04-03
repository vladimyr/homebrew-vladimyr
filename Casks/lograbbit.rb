cask 'lograbbit' do
  version '1.8_33'
  sha256 'b0025a3827782cf354af9e6113cec4a79d9c8d8eb3d5321674c65b6b379af55c'

  url "http://lograbbit.com/assets/app/LogRabbit_Trial_#{version}.dmg"
  name 'LogRabbit'
  homepage 'http://lograbbit.com/'

  auto_updates true

  app 'LogRabbitTrial.app'

  zap trash: [
               '~/Library/Application Scripts/com.lograbbit.LogRabbit-Trial',
               '~/Library/Containers/com.lograbbit.LogRabbit-Trial',
             ]
end
