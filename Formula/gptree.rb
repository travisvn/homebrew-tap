class Gptree < Formula
  desc "Project tree structure and file content aggregator for providing LLM context"
  homepage "https://github.com/travisvn/gptree"
  license "MIT"
  version "v1.1.3"

  depends_on "python" => :optional

  on_macos do
    url "https://github.com/travisvn/gptree/releases/download/v1.1.3/gptree-macos"
    sha256 "cd20e3ed56659bbce313522abc84397ef06a844a48f964ee7d8e64354ad58e38"
  end

  on_linux do
    url "https://github.com/travisvn/gptree/releases/download/v1.1.3/gptree-ubuntu"
    sha256 "7e1d3559833af8f4f37ae13ac17910050d826b938ee70b7877c406560d0e9acd"
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
    # Find python3 and pip3 in the user's PATH
    python_path = /usr/bin/python3.chomp
    pip_path = /usr/bin/pip3.chomp

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
    assert_match "usage", shell_output("#{bin}/gptree --help")
  end
end
