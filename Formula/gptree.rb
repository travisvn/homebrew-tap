class Gptree < Formula
  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  license "MIT"
  version "v1.0.10"

  on_macos do
    url "https://github.com/travisvn/gptree/releases/download/v1.0.10/gptree-macos"
    sha256 "10f5af4fa88f0aeab0b7191608f8e693f7cd72561a185866f8f8071b3013c573"
  end

  on_linux do
    url "https://github.com/travisvn/gptree/releases/download/v1.0.10/gptree-ubuntu"
    sha256 "434b682ada6f338f9034d6df95b9802e4efe13621276dff2201bcba63f50d0a4"
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
