class Gptree < Formula
  include Language::Python::Virtualenv

  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  version "v1.1.4"
  license "GPLv3"

  depends_on "python" => :optional

  on_macos do
    url "https://github.com/travisvn/gptree/releases/download/v1.1.4/gptree-macos"
    sha256 "5744233de0a0238e5b53239d5dd25753dbbc182a66c123776367dba07e26dbff"
  end

  on_linux do
    url "https://github.com/travisvn/gptree/releases/download/v1.1.4/gptree-ubuntu"
    sha256 "ad94bba4082fd3d5b17eb945d94e802f4e7ab657fef6cd75e5f86c9ae7845a2d"
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

    if !python_path.empty? && !pip_path.empty? && system("\#{python_path}", "--version") && system("\#{pip_path}", "--version")
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
