class SshGit < Formula
  desc "Control git ssh identity"
  homepage "https://github.com/vladimyr/shellscripts"
  url "https://github.com/vladimyr/shellscripts.git"
  version "1"

  def install
    bin.install "scripts/ssh-git"
  end

  def caveats
    <<~CAVEATS
      In order to complete the installation, please add the following to your shell profile:

      GIT_SSH=ssh-git
    CAVEATS
  end
end
