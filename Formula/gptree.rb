  class Gptree < Formula
    include Language::Python::Virtualenv
  
    desc "Project tree structure and file content aggregator for providing LLM context"
    homepage "https://github.com/travisvn/gptree"
    version "v1.1.1"
    license "MIT"
  
    depends_on "python" => :optional
  
    on_macos do
      url "https://github.com/travisvn/gptree/releases/download/v1.1.1/gptree-macos"
      sha256 "1621b5d319b1c08ef4e175572f84ac728e4d11bf5a96438c143e2a353c8207c5"
    end
  
    on_linux do
      url "https://github.com/travisvn/gptree/releases/download/v1.1.1/gptree-ubuntu"
      sha256 "aa3b254d3f9d8e4686036a8cb1dd2520cd7d4e62790a67520eadff011af3c679"
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
      python_path = Formula["python"].opt_bin/"python3" if Formula["python"].linked_keg.exist?
      pip_path = Formula["python"].opt_bin/"pip3" if Formula["python"].linked_keg.exist?
  
      if python_path && File.exist?(python_path) && system("#{pip_path} --version")
        opoo "Python and pip detected. Installing with pip."
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
  