class Officecdncheck < Formula
  desc "Microsoft Office CDN Version Check"
  homepage "https://github.com/pbowden-msft/OfficeCDNCheck"
  url "https://github.com/pbowden-msft/OfficeCDNCheck/archive/9c33167.tar.gz"
  version "2.6"
  sha256 "946087cf04ca7fd05cc4bb0b5c8f5d824201dec437f91877bee2f56c49f3c04d"
  head "https://github.com/pbowden-msft/OfficeCDNCheck.git"

  livecheck do
    url "https://raw.githubusercontent.com/pbowden-msft/OfficeCDNCheck/master/OfficeCDNCheck"
    regex(/TOOL_VERSION="v?(\d+(?:\.\d+)+)"/i)
  end

  def install
    bin.install "OfficeCDNCheck"
  end
end
