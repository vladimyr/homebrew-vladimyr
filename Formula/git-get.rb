class GitGet < Formula
  desc "Clone git repositories to $HOME/workspace/github.com/<user>/<repo>"
  homepage "https://github.com/vladimyr/shellscripts"
  url "https://github.com/vladimyr/shellscripts.git"
  version "1"

  depends_on "hub"

  def install
    bin.install "scripts/git-get"
  end

  test do
    expected = "hub clone github/hub #{testpath}/github.com/github/hub"
    output = shell_output("GIT_GET_PATH=#{testpath} git get -n github/hub").strip
    assert_equal expected, output
  end
end
