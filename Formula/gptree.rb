class Gptree < Formula
  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  license "MIT"
  version "v1.0.8"

  on_macos do
    url "https://github.com/travisvn/gptree/releases/download/v1.0.8/gptree-macos"
    sha256 "4042d3184f04acf685a2d1a8d8b4414da31a6c689915519890f8a2371dfc8984"
  end

  on_linux do
    url "https://github.com/travisvn/gptree/releases/download/v1.0.8/gptree-ubuntu"
    sha256 "1fa0a8b10a6ff5d6c612b81148dd4db8d027fbf2a04154272bc04a9b1c6eaf7b"
  end

  def install
    if OS.mac?
      bin.install "gptree-macos" => "gptree"
    elsif OS.linux?
      bin.install "gptree-ubuntu" => "gptree"
    end
  end

  test do
    system "#{bin}/gptree", "--version"
  end
end
