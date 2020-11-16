cask "color-picker" do
  version "0.3"
  sha256 "abbbcbdbd69dca10858f322796fb08c39dbbeaabd17fac9fa7c4036ad69106da"

  url "https://github.com/nrlquaker/color-picker-launcher/releases/download/v#{version}/color.picker.v#{version}.zip"
  appcast "https://github.com/nrlquaker/color-picker-launcher/releases.atom"
  name "Color Picker"
  homepage "https://github.com/nrlquaker/color-picker-launcher/"

  app "Color Picker.app"

  zap trash: "~/Library/Preferences/com.apple.ScriptEditor.id.Color-picker.plist"
end
