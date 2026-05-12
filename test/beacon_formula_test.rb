# frozen_string_literal: true

require "minitest/autorun"

module Language
  module Python
    module Virtualenv
    end
  end
end

class Formula
  Resource = Struct.new(:url_value, :sha256_value) do
    def url(value)
      self.url_value = value
    end

    def sha256(value)
      self.sha256_value = value
    end
  end

  class << self
    attr_reader :desc_value, :homepage_value, :url_value, :sha256_value,
                :license_value, :dependencies, :resources, :test_block

    def desc(value)
      @desc_value = value
    end

    def homepage(value)
      @homepage_value = value
    end

    def url(value)
      @url_value = value
    end

    def sha256(value)
      @sha256_value = value
    end

    def license(value)
      @license_value = value
    end

    def depends_on(value)
      @dependencies ||= []
      @dependencies << value
    end

    def resource(name, &block)
      @resources ||= {}
      resource = Resource.new
      resource.instance_eval(&block)
      @resources[name] = resource
    end

    def test(&block)
      @test_block = block
    end
  end

  attr_reader :system_calls

  def system(*args)
    @system_calls ||= []
    @system_calls << args
  end
end

load File.expand_path("../Formula/beacon.rb", __dir__)
load File.expand_path("../Formula/clawrtc.rb", __dir__)

class BeaconFormulaTest < Minitest::Test
  def test_beacon_formula_metadata
    assert_includes Beacon.desc_value, "AI agent orchestrator"
    assert_equal "https://bottube.ai/skills/beacon", Beacon.homepage_value
    assert_equal "https://files.pythonhosted.org/packages/source/b/beacon-skill/beacon_skill-2.15.1.tar.gz", Beacon.url_value
    assert_equal "2a970a275863605254f9e7e8e67b6cd67fc8de647210d2ec82f0ac2e870cb518", Beacon.sha256_value
    assert_equal "MIT", Beacon.license_value
    assert_equal ["python@3"], Beacon.dependencies
  end

  def test_beacon_resources_have_pinned_archives
    assert_equal ["cryptography", "requests"], Beacon.resources.keys.sort

    requests = Beacon.resources.fetch("requests")
    assert_equal "https://files.pythonhosted.org/packages/source/r/requests/requests-2.31.0.tar.gz", requests.url_value
    assert_equal "942c5a758f98d790eaed1a29cb6eefc7f0edf3fcb0fce8b0511f7a990d33c1f6", requests.sha256_value

    cryptography = Beacon.resources.fetch("cryptography")
    assert_equal "https://files.pythonhosted.org/packages/source/c/cryptography/cryptography-41.0.7.tar.gz", cryptography.url_value
    assert_equal "13f93ce9bea8016c5e4ec8f415a863fca6b4b0a2e34885f3e9d2e6e07c88e5e8", cryptography.sha256_value
  end

  def test_beacon_caveats_include_expected_commands
    caveats = Beacon.new.caveats

    assert_includes caveats, "Beacon 2.15.1 installed"
    assert_includes caveats, "beacon init"
    assert_includes caveats, "beacon atlas estimate <agent_id>"
    assert_includes caveats, "beacon rustchain pay RTCabc... 1.5"
    assert_includes caveats, "https://github.com/Scottcjn/beacon-skill"
  end

  def test_beacon_homebrew_test_imports_package
    formula = Beacon.new
    formula.instance_eval(&Beacon.test_block)

    assert_equal [["python3", "-c", "import beacon_skill"]], formula.system_calls
  end

  def test_clawrtc_formula_metadata_is_still_valid
    assert_includes Clawrtc.desc_value, "RustChain miner"
    assert_equal "https://github.com/Scottcjn/Rustchain", Clawrtc.homepage_value
    assert_equal "https://files.pythonhosted.org/packages/da/23/44c4e03bfb3d03635594fe18afda4a7f157464641e7b035e9ddd91f8c48f/clawrtc-1.7.1.tar.gz", Clawrtc.url_value
    assert_equal "d609eb74f9d833092595295893d5c616bfed2d6685ea21eeeca9dfcdddd30484", Clawrtc.sha256_value
    assert_equal "MIT", Clawrtc.license_value
    assert_equal ["python@3"], Clawrtc.dependencies
  end

  def test_clawrtc_caveats_and_test_block
    caveats = Clawrtc.new.caveats
    formula = Clawrtc.new
    formula.instance_eval(&Clawrtc.test_block)

    assert_includes caveats, "ClawRTC 1.7.1 installed"
    assert_includes caveats, "clawrtc mine --wallet <your_wallet>"
    assert_includes caveats, "clawrtc wallet create <name>"
    assert_includes caveats, "https://github.com/Scottcjn/Rustchain"
    assert_equal [["python3", "-c", "import clawrtc"]], formula.system_calls
  end
end
