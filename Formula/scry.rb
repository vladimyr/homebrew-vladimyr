class Scry < Formula
  desc "Code analysis server for Crystal programming language"
  homepage "https://github.com/crystal-lang-tools/scry/"
  url "https://github.com/crystal-lang-tools/scry/archive/v0.9.1.tar.gz"
  sha256 "53bf972557f8b6a697d2aa727df465d6e7d04f6426fcd4559a4d77c90becad81"
  license "MIT"
  head "https://github.com/crystal-lang-tools/scry.git"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "crystal" => :build
  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "pcre"

  uses_from_macos "libiconv"

  def install
    system "shards", "build",
           "--release", "--no-debug", "--verbose",
           "--ignore-crystal-version"
    bin.install "bin/scry"
  end

  test do
    require "json"
    require "open3"

    begin
      request = {
        jsonrpc: "2.0",
        id:      1,
        method:  "initialize",
        params:  {
          rootPath:     "path/to/project",
          capabilities: {},
          trace:        "off",
        },
      }.to_json

      response = {
        jsonrpc: "2.0",
        id:      1,
        result:  {
          capabilities: {
            textDocumentSync:           "full",
            documentFormattingProvider: true,
            definitionProvider:         true,
            documentSymbolProvider:     true,
            workspaceSymbolProvider:    true,
            completionProvider:         {
              resolveProvider:   true,
              triggerCharacters: [".", "\"", "/"],
            },
            hoverProvider:              true,
          },
        },
      }.to_json

      stdin, stdout, _, wait_thr = Open3.popen3(bin/"scry")
      stdin.write <<~EOF
        Content-Length: #{request.length}

        #{request}
      EOF

      while (output = stdout.gets.split("Content-Length: ").first)
        break if output.include? "\"id\":1"
      end
      assert_equal response, output
    ensure
      Process.kill "SIGKILL", wait_thr.pid
    end
  end
end
