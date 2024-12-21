class Gptree < Formula
  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  license "MIT"
  version "v1.1.2"

  depends_on "python@3.9" => :optional

  def install
    if system("which pip3")
      # Attempt to install via pip
      pip_success = system("pip3", "install", "gptree-cli==v1.1.2", "--prefix=#{prefix}")
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
      url = "https://github.com/travisvn/gptree/releases/download/v1.1.2/gptree-macos"
      sha256 = "f73e22296a923d53e53abd682310a4d9d52a27e4c6b23b1a22f2c4921841a78b"
      fetch_and_install(url, sha256, "gptree-macos")
    elsif OS.linux?
      url = "https://github.com/travisvn/gptree/releases/download/v1.1.2/gptree-ubuntu"
      sha256 = "f1d7c0b9b4dd87bf40dd2b3adbe5a6525572e1fd278c5a0e8062251f455be740"
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
