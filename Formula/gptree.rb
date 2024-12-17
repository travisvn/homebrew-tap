class Gptree < Formula
  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  license "MIT"
  version "v1.1.0"

  on_macos do
    url "https://github.com/travisvn/gptree/releases/download/v1.1.0/gptree-macos"
    sha256 "1070982934576993718bec83fb9b204701ad4aa77de0345e56ec246321a82bfb"
  end

  on_linux do
    url "https://github.com/travisvn/gptree/releases/download/v1.1.0/gptree-ubuntu"
    sha256 "9e39b29e41de9cd6e27891be1fb04f3fea855f064b69d56d3c4735f76b69cb08"
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
