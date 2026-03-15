class Clawrtc < Formula
  include Language::Python::Virtualenv

  desc "RustChain miner — Proof-of-Antiquity mining with hardware fingerprinting and built-in wallet"
  homepage "https://github.com/Scottcjn/Rustchain"
  url "https://files.pythonhosted.org/packages/da/23/44c4e03bfb3d03635594fe18afda4a7f157464641e7b035e9ddd91f8c48f/clawrtc-1.7.1.tar.gz"
  sha256 "d609eb74f9d833092595295893d5c616bfed2d6685ea21eeeca9dfcdddd30484"
  license "MIT"

  depends_on "python@3"

  resource "requests" do
    url "https://files.pythonhosted.org/packages/source/r/requests/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7f0edf3fcb0fce8b0511f7a990d33c1f6"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/source/c/cryptography/cryptography-41.0.7.tar.gz"
    sha256 "13f93ce9bea8016c5e4ec8f415a863fca6b4b0a2e34885f3e9d2e6e07c88e5e8"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      ClawRTC 1.7.1 installed! RustChain miner with Proof-of-Antiquity:

        clawrtc mine --wallet <your_wallet>    # Start mining
        clawrtc wallet create <name>           # Create a wallet
        clawrtc wallet balance <name>          # Check balance
        clawrtc attest                         # Submit hardware attestation

      Older hardware earns higher multipliers (Proof-of-Antiquity).
      Supported: x86, ARM, PowerPC, SPARC, POWER8, and more.

      Docs: https://github.com/Scottcjn/Rustchain
    EOS
  end

  test do
    system "python3", "-c", "import clawrtc"
  end
end
