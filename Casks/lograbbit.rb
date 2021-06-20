cask "lograbbit" do
  version "1.8,33"
  sha256 "b0025a3827782cf354af9e6113cec4a79d9c8d8eb3d5321674c65b6b379af55c"

  url "http://lograbbit.com/assets/app/LogRabbit_Trial_#{version.before_comma}_#{version.after_comma}.dmg"
  name "LogRabbit"
  desc "Android logcat viewer"
  homepage "http://lograbbit.com/"

  livecheck do
    url :homepage
    strategy :page_match do |page|
      match = page.match(/href=.*?LogRabbit_Trial[._-]v?(\d+(?:\.\d+)*)_(\d+)\.dmg/i)
      "#{match[1]},#{match[2]}"
    end
  end

  app "LogRabbitTrial.app"

  zap trash: [
    "~/Library/Application Scripts/com.lograbbit.LogRabbit-Trial",
    "~/Library/Containers/com.lograbbit.LogRabbit-Trial",
  ]
end
