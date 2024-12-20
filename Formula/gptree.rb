class Gptree < Formula
  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  license "MIT"
  version "v1.1.1"

  depends_on "python@3.9" => :optional

  def install
    if system("which pip3")
      # Attempt to install via pip
      pip_success = system("pip3", "install", "gptree-cli==v1.1.1", "--prefix=#{prefix}")
      unless pip_success
        opoo "pip3 installation failed. Falling back to binary installation."
        download_and_install_binary
      end
    else
      # Fallback to binary installation if pip3 isn't available
      download_and_install_binary
    end
  end

  def download_and_install_binary
    if OS.mac?
      url = "https://github.com/travisvn/gptree/releases/download/v1.1.1/gptree-macos"
      sha256 = "1621b5d319b1c08ef4e175572f84ac728e4d11bf5a96438c143e2a353c8207c5"
      fetch_and_install(url, sha256, "gptree-macos")
    elsif OS.linux?
      url = "https://github.com/travisvn/gptree/releases/download/v1.1.1/gptree-ubuntu"
      sha256 = "aa3b254d3f9d8e4686036a8cb1dd2520cd7d4e62790a67520eadff011af3c679"
      fetch_and_install(url, sha256, "gptree-ubuntu")
    end
  end

  def fetch_and_install(url, sha256, filename)
    # Download the file manually
    resource filename do
      url url
      sha256 sha256
    end

    resource(filename).stage do
      bin.install filename => "gptree"
    end
  end

  test do
    assert_match "usage", shell_output("#{bin}/gptree --help")
  end
end
