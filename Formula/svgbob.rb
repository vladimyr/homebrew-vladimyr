class Svgbob < Formula
  desc "Convert your ascii diagram scribbles into happy little SVG"
  homepage "https://ivanceras.github.io/svgbob-editor/"
  url "https://github.com/ivanceras/svgbob/archive/0.5.0.tar.gz"
  sha256 "731de78542ad5bbe7400711e1b3b98ef191506b766bd36745629108356d312b1"
  license "Apache-2.0"
  head "https://github.com/ivanceras/svgbob.git"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    cd "svgbob_cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    (testpath/"ascii.txt").write <<~EOS
      +------------------+
      |                  |
      |  Hello Homebrew  |
      |                  |
      +------------------+
    EOS

    system "#{bin}/svgbob", "ascii.txt", "-o", "out.svg"
    assert_predicate testpath/"out.svg", :exist?

    require "rexml/document"

    doc = REXML::Document.new(File.new(testpath/"out.svg"))
    assert svg = doc.root
    assert_not_nil svg.elements["rect[contains(@class, solid)]"]
    assert_equal "Hello Homebrew", svg.elements.to_a("text").map(&:text).join(" ")
  end
end
