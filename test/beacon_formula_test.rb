# frozen_string_literal: true

require "minitest/autorun"
require "pathname"

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

  # Stand-ins for the bits of the Homebrew DSL the `test do` block touches.
  PREFIX = Pathname.new("/opt/homebrew/opt/beacon")

  # What `beacon --help` actually prints once the formula installs a working
  # virtualenv (captured from beacon-skill 2.15.1).
  HELP_OUTPUT = <<~OUT
    usage: beacon [-h] [--version]
                  {init,decode,identity,inbox,udp,bottube,rustchain,heartbeat,accord,atlas}
                  ...

    Beacon - autonomous agent economy: presence, trust, feed, rules, tasks,
    memory, outbox, executor, mayday, heartbeat, accord
  OUT

  attr_reader :system_calls, :shell_commands

  def bin
    PREFIX/"bin"
  end

  def libexec
    PREFIX/"libexec"
  end

  def system(*args)
    @system_calls ||= []
    @system_calls << args.map(&:to_s)
  end

  def shell_output(command, _result = 0)
    @shell_commands ||= []
    @shell_commands << command
    HELP_OUTPUT
  end

  def assert_match(pattern, string)
    return if string.match?(pattern.is_a?(Regexp) ? pattern : Regexp.new(Regexp.escape(pattern)))

    raise "formula test assertion failed: #{pattern.inspect} not found in #{string.inspect}"
  end
end

load File.expand_path("../Formula/beacon.rb", __dir__)
load File.expand_path("../Formula/clawrtc.rb", __dir__)

class BeaconFormulaTest < Minitest::Test
  # Every distribution beacon_skill 2.15.1 needs to be importable. requests and
  # cryptography are its declared runtime deps; the rest are their transitive
  # deps (Homebrew installs resources with pip --no-deps, so nothing is pulled
  # in automatically) plus flask, which beacon_skill/__init__.py needs at import
  # time even though upstream lists it only under the "conway" extra.
  EXPECTED_RESOURCES = %w[
    blinker certifi cffi charset-normalizer click cryptography flask idna
    itsdangerous jinja2 markupsafe pycparser requests urllib3 werkzeug
  ].freeze

  # cryptography gained Python 3.12 support in 42.0; earlier releases abort with
  # pyo3_runtime.PanicException when imported, whatever python@3 currently is.
  MIN_CRYPTOGRAPHY = Gem::Version.new("42.0")

  def test_beacon_formula_metadata
    assert_includes Beacon.desc_value, "AI agent orchestrator"
    assert_equal "https://bottube.ai/skills/beacon", Beacon.homepage_value
    assert_equal "https://files.pythonhosted.org/packages/source/b/beacon-skill/beacon_skill-2.15.1.tar.gz", Beacon.url_value
    assert_equal "2a970a275863605254f9e7e8e67b6cd67fc8de647210d2ec82f0ac2e870cb518", Beacon.sha256_value
    assert_equal "MIT", Beacon.license_value
    assert_includes Beacon.dependencies, "python@3"
  end

  def test_beacon_declares_the_build_deps_cryptography_needs_from_source
    # Homebrew installs resources with `pip --no-binary :all:`, so
    # cryptography's Rust extension is compiled during `brew install`.
    assert_includes Beacon.dependencies, { "rust" => :build }
    assert_includes Beacon.dependencies, "openssl@3"
  end

  def test_beacon_resources_cover_every_import_time_dependency
    assert_equal EXPECTED_RESOURCES.sort, Beacon.resources.keys.sort
  end

  def test_beacon_resources_have_pinned_archives
    Beacon.resources.each do |name, resource|
      assert_match(/\A[0-9a-f]{64}\z/, resource.sha256_value, "#{name} sha256 is not a sha256")
      assert resource.url_value.start_with?("https://files.pythonhosted.org/packages/"),
             "#{name} is not pinned to a PyPI archive"
      assert resource.url_value.end_with?(".tar.gz"), "#{name} is not pinned to an sdist"
    end

    requests = Beacon.resources.fetch("requests")
    assert_equal "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1", requests.sha256_value
    assert_includes requests.url_value, "requests-2.31.0.tar.gz"
  end

  def test_cryptography_pin_can_be_imported_on_a_current_python
    cryptography = Beacon.resources.fetch("cryptography")
    version = Gem::Version.new(cryptography.url_value[%r{/cryptography-(\d[^/]*)\.tar\.gz\z}, 1])

    assert_operator version, :>=, MIN_CRYPTOGRAPHY,
                    "cryptography #{version} cannot be imported on Python 3.12+"
    assert_equal "bfd019f60f8abc2ed1b9be4ddc21cfef059c841d86d710bb69909a688cbb8f59", cryptography.sha256_value
  end

  def test_beacon_caveats_include_expected_commands
    caveats = Beacon.new.caveats

    assert_includes caveats, "Beacon 2.15.1 installed"
    assert_includes caveats, "beacon init"
    assert_includes caveats, "beacon atlas estimate <agent_id>"
    assert_includes caveats, "beacon rustchain pay RTCabc... 1.5"
    assert_includes caveats, "https://github.com/Scottcjn/beacon-skill"
  end

  def test_beacon_homebrew_test_runs_the_installed_binary
    formula = Beacon.new
    formula.instance_eval(&Beacon.test_block)

    assert_includes formula.shell_commands, "#{formula.bin}/beacon --help"
  end

  def test_beacon_homebrew_test_imports_through_the_virtualenv_python
    # `python3` on PATH cannot see a virtualenv that lives in libexec, so an
    # import check run with it fails no matter how healthy the install is.
    formula = Beacon.new
    formula.instance_eval(&Beacon.test_block)

    assert_equal [["#{formula.libexec}/bin/python", "-c", "import beacon_skill"]], formula.system_calls
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
