class Miranda < Formula
  desc "Lazy, purely functional programming language"
  homepage "http://miranda.org.uk/"
  url "https://www.cs.kent.ac.uk/people/staff/dat/miranda/src/mira-2066-src.tgz"
  version "2.066"
  sha256 "521c281e8c2fde87a2cd7c41d9677daa09514debb71435efc08ff3a7c20016eb"

  depends_on "byacc" => :build

  def install
    # Make tasks are required to run sequentially
    ENV.deparallelize

    # Makefile assumes that provided paths exist
    bin.mkpath
    lib.mkpath
    man1.mkpath

    inreplace "Makefile" do |s|
      # Do NOT touch `#{lib}/miralib/` permissions
      s.gsub! "./protect", "/usr/bin/true"
      s.gsub! "./unprotect", "/usr/bin/true"
      # Do NOT change `#{lib}/miralib/` ownership
      s.gsub! "./ugroot", "whoami"
    end

    # Remove compiled files
    system "make", "cleanup"

    # Set sources creation date to current date.
    touch "miralib/prelude"
    touch Dir["miralib/**/*.m"]

    system "make", "install",
           "CC=#{ENV.cc}", "CFLAGS=-O",
           "BIN=#{bin}", "LIB=#{lib}", "MAN=#{man1}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mira -version")

    (testpath/"test.m").write <<~EOS
      main = [ Stdout "it works!\\n" ]
    EOS

    assert_equal "it works!\n", shell_output("#{bin}/mira -exec test.m")
  end
end
