class GatherWindows < Formula
  desc "XQuartz window management helper"
  homepage "https://peppertop.com/blog/?p=1554"
  url "https://peppertop.com/gather_windows.sh"
  version "1"
  sha256 "096cf2f4ffa8d8c4e4bb659bd184e8fc114bbc2406b930df8cbfe5ab67270fd4"

  bottle :unneeded

  depends_on "wmctrl"

  def install
    bin.install "gather_windows.sh" => "gather-windows"
  end

  test do
    assert_match "Usage: gather_windows.sh [option]",
                 shell_output("#{bin}/gather-windows --help")
  end
end
