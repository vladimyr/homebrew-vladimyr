class Scry < Formula
  desc "Code analysis server for Crystal programming language"
  homepage "https://github.com/crystal-lang-tools/scry/"
  url "https://github.com/crystal-lang-tools/scry/archive/v0.8.1.tar.gz"
  sha256 "31ce6d310c9485c5d3c87aa0e4fc07808b1ad122e73a485d26ed206f2c3d9c24"
  head "https://github.com/crystal-lang-tools/scry.git"

  depends_on "crystal" => :build

  def install
    system "shards", "build", "--release"
    bin.install "bin/scry"
  end

  test do
    require "json"

    begin
      request = {
        :jsonrpc => "2.0",
        :id      => 1,
        :method  => "initialize",
        :params  => {
          :rootPath     => "path/to/project",
          :capabilities => {},
          :trace        => "off",
        },
      }.to_json

      response = {
        :jsonrpc => "2.0",
        :id      => 1,
        :result  => {
          :capabilities => {
            :textDocumentSync           => 1,
            :documentFormattingProvider => true,
            :definitionProvider         => true,
            :documentSymbolProvider     => true,
            :workspaceSymbolProvider    => true,
            :completionProvider         => {
              :resolveProvider   => true,
              :triggerCharacters => [".", "\"", "/"],
            },
            :hoverProvider              => true,
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
