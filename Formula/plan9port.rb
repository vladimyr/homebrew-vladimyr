class Plan9port < Formula
  REVISION = "bfe4377".freeze

  desc "Plan 9 from User Space"
  homepage "https://9fans.github.io/plan9port/"
  url "https://github.com/9fans/plan9port/archive/#{REVISION}.tar.gz"
  version "master@#{REVISION}"
  sha256 "4ef5acf5b3e271149961f014dd3c01b356bf8827bbe37bfc050129a2d4721a39"
  head "https://github.com/9fans/plan9port.git"

  def install
    ENV["PLAN9_TARGET"] = libexec
    system "./INSTALL"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/9"
    prefix.install Dir[libexec/"mac/*.app"]
  end

  def caveats
    <<~EOS
      In order not to collide with macOS system binaries, the Plan 9 binaries have
      been installed to #{opt_libexec}/bin.
      To run the Plan 9 version of a command simply call it through the command
      "9", which has been installed into the Homebrew prefix bin.  For example,
      to run Plan 9's ls run:
          # 9 ls
    EOS
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <u.h>
      #include <libc.h>
      #include <stdio.h>

      int main(void) {
        return printf("Hello World\\n");
      }
    EOS
    system bin/"9", "9c", "test.c"
    system bin/"9", "9l", "-o", "test", "test.o"
    assert_equal "Hello World\n", shell_output("./test", 1)
  end
end
