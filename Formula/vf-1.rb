class Vf1 < Formula
  desc "Command-line gopher client"
  homepage "https://github.com/solderpunk/vf-1/"
  url "https://github.com/solderpunk/VF-1/archive/v0.0.11.tar.gz"
  sha256 "021d2020cddb5ef83e9c26038df95bbb4a6ad9c4cdc7303cbda9c4129856db0e"
  head "https://github.com/solderpunk/vf-1.git"

  depends_on "python@3.8"

  def install
    system Formula["python@3.8"].opt_bin/"python3",
           *Language::Python.setup_install_args(prefix)
    if build.head?
      man1.install "vf1.1"
      man7.install "vf1-tutorial.7"
    end
  end

  test do
    stdin, stdout, wait_thr = Open3.popen2("#{bin}/vf1", "gopher://floodgap.com")
    assert_equal stdout.gets, "Welcome to Floodgap Systems' official gopher server.\n"
    stdin.puts "quit"
  ensure
    Process.kill("TERM", wait_thr.pid)
  end
end
