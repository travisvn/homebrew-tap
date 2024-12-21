  class Gptree < Formula
    include Language::Python::Virtualenv
  
    desc "Project tree structure and file content aggregator for providing LLM context"
    homepage "https://github.com/travisvn/gptree"
    version "1.1.1"
    license "MIT"
  
    depends_on "python@3.9" => :optional
  
    on_macos do
      url "https://github.com/travisvn/gptree/releases/download/v1.1.1/gptree-macos"
      sha256 "1621b5d319b1c08ef4e175572f84ac728e4d11bf5a96438c143e2a353c8207c5"
    end
  
    on_linux do
      url "https://github.com/travisvn/gptree/releases/download/v1.1.1/gptree-ubuntu"
      sha256 "aa3b254d3f9d8e4686036a8cb1dd2520cd7d4e62790a67520eadff011af3c679"
    end
  
    resource "pyperclip" do
      url "https://files.pythonhosted.org/packages/source/p/pyperclip/pyperclip-1.8.2.tar.gz"
      sha256 "e7bc33d8b99c4ec5a27af3a3f9aa6d198f40adf08b58b1206469d91701b987b8"
    end
  
    resource "pathspec" do
      url "https://files.pythonhosted.org/packages/source/p/pathspec/pathspec-0.10.3.tar.gz"
      sha256 "46b3d6b39ab1a07e6da29a234567fb1e875e9a535eaf75516d4c6d32e13eac20"
    end
  
    def install
      if Formula["python@3.9"].linked_keg.exist? && system("which pip3")
        opoo "Python and pip3 detected. Installing with pip."
        virtualenv_install_with_resources
      else
        opoo "Python or pip3 not detected. Falling back to binary installation."
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
  