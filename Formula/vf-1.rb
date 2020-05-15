class Vf1 < Formula
  desc "Command-line gopher client"
  homepage "https://github.com/solderpunk/vf-1/"
  url "https://github.com/solderpunk/VF-1/archive/v0.0.11.tar.gz"
  sha256 "021d2020cddb5ef83e9c26038df95bbb4a6ad9c4cdc7303cbda9c4129856db0e"
  head "https://github.com/solderpunk/vf-1.git"

  depends_on "python@3.8"

  def install
    system Formula["python@3.8"].opt_bin/"python3",
           "setup.py", "install", "--prefix=#{prefix}"
    if build.head?
      man1.install "vf1.1"
      man7.install "vf1-tutorial.7"
    end
  end

  test do
    port = free_port
    server = TCPServer.new(port)
    server_pid = fork do
      connection = server.accept
      msg = connection.gets
      assert_equal msg, "\r\n"
      connection.puts "iHello world!\tfake\ttest.localhost\t0\r"
      connection.puts ".\r"
      connection.close
      server.close
    end

    stdin, stdout, wait_thr = Open3.popen2("#{bin}/vf1", "127.0.0.1:#{port}")
    assert_equal stdout.gets, "Hello world!\n"
    stdin.puts "quit"
    Process.wait(wait_thr.pid)
  ensure
    Process.kill("TERM", server_pid)
  end
end
