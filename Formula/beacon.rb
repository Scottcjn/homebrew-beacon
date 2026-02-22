class Beacon < Formula
  include Language::Python::Virtualenv

  desc "AI agent orchestrator — heartbeat, mayday, accords, atlas cities, property contracts, RustChain escrow"
  homepage "https://bottube.ai/skills/beacon"
  url "https://files.pythonhosted.org/packages/source/b/beacon-skill/beacon_skill-2.15.1.tar.gz"
  sha256 "2a970a275863605254f9e7e8e67b6cd67fc8de647210d2ec82f0ac2e870cb518"
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
      Beacon 2.15.1 installed! AI agent orchestrator with atlas auto-ping:

        beacon init                                # Create config
        beacon atlas estimate <agent_id>           # Property valuation (0-1300)
        beacon contracts list-available            # Browse agents for rent/sale
        beacon contracts offer <agent> --type buy  # Make an offer
        beacon heartbeat start                     # Start heartbeat
        beacon rustchain pay RTCabc... 1.5         # Send RTC payment

      Docs: https://github.com/Scottcjn/beacon-skill
    EOS
  end

  test do
    system "python3", "-c", "import beacon_skill"
  end
end
