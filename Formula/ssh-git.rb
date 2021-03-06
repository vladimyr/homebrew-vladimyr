class SshGit < Formula
  desc "Control git ssh identity"
  homepage "https://github.com/vladimyr/shellscripts"
  url "https://github.com/vladimyr/shellscripts.git"
  version "1"

  def install
    lib.install "scripts/ssh-git.sh"
  end

  def caveats
    <<~CAVEATS
      In order to complete the installation,
      please add the following to your shell profile:

      GIT_SSH="$(brew --prefix)/lib/ssh-git.sh"
    CAVEATS
  end
end
