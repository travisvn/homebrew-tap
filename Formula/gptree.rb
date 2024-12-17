class Gptree < Formula
  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  license "MIT"
  version "v1.0.9"

  on_macos do
    url "https://github.com/travisvn/gptree/releases/download/v1.0.9/gptree-macos"
    sha256 "ca50f313397c4d6a1ab59a9de85c4f033a6450d499935dfc5cf38b1278c13eb0"
  end

  on_linux do
    url "https://github.com/travisvn/gptree/releases/download/v1.0.9/gptree-ubuntu"
    sha256 "333177913b26bab0057aad9a631e3ffa0bac92446a9f8720d7335b21840faef4"
  end

  def install
    if OS.mac?
      bin.install "gptree-macos" => "gptree"
    elsif OS.linux?
      bin.install "gptree-ubuntu" => "gptree"
    end
  end

  test do
    assert_match "usage", shell_output("#{bin}/gptree --help")
  end
end
