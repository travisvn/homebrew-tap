class Gptree < Formula
  include Language::Python::Virtualenv

  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  version "v1.6.0"
  license "GPLv3"

  depends_on "python" => :optional

  on_macos do
    url "https://github.com/travisvn/gptree/releases/download/v1.6.0/gptree-macos"
    sha256 "90188b3474f3e7c0a0bc4f22f64fa09b6477b054de9671d5d2acaecdadc04404"
  end

  on_linux do
    url "https://github.com/travisvn/gptree/releases/download/v1.6.0/gptree-ubuntu"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/source/p/pyperclip/pyperclip-1.9.0.tar.gz"
    sha256 "b7de0142ddc81bfc5c7507eea19da920b92252b548b96186caf94a5e2527d310"
  end

  resource "pathspec" do
    url "https://files.pythonhosted.org/packages/source/p/pathspec/pathspec-0.12.1.tar.gz"
    sha256 "a482d51503a1ab33b1c67a6c3813a26953dbdc71c31dacaef9a838c4e29f5712"
  end

  def install
    python_path = `which python3`.chomp
    pip_path = `which pip3`.chomp

    if !python_path.empty? && !pip_path.empty? && system("#{python_path}", "--version") && system("#{pip_path}", "--version")
      opoo "Python and pip detected. Installing with pip."
      ENV.prepend_path "PATH", File.dirname(python_path) # Ensure the detected Python is prioritized
      virtualenv_install_with_resources
    else
      opoo "Python or pip not detected. Falling back to binary installation."
      install_binary
    end
  end

  def install_binary
    if OS.mac?
      bin.install "gptree-macos" => "gptree"
    elsif OS.linux?
      bin.install "gptree-ubuntu" => "gptree"
    end
  end

  test do
    assert_match "usage", shell_output("\#{bin}/gptree --help")
  end
end
