# Contributing to homebrew-beacon

Thank you for your interest in contributing to the Beacon Homebrew tap! This guide will help you get started with contributing formulas, reporting issues, and improving the tap.

## Table of Contents

- [About Beacon](#about-beacon)
- [Development Setup](#development-setup)
- [Contributing Formulas](#contributing-formulas)
- [Formula Guidelines](#formula-guidelines)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Code of Conduct](#code-of-conduct)

## About Beacon

Beacon is an agent ping + RTC + UDP bus system designed for distributed agent communication. This Homebrew tap provides easy installation and updates for Beacon on macOS and Linux systems.

**Key Features:**
- Agent heartbeat and status monitoring
- Real-time communication via WebRTC
- UDP bus for lightweight messaging
- Cross-platform support (macOS, Linux)

## Development Setup

### Prerequisites

- **macOS**: macOS 10.14 (Mojave) or later
- **Linux**: Ubuntu 18.04+, Debian 9+, or equivalent
- **Homebrew**: Latest version (`brew update`)
- **Git**: For cloning and submitting changes

### Fork and Clone

1. Fork this repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/homebrew-beacon.git
   cd homebrew-beacon
   ```

3. Set up the upstream remote:
   ```bash
   git remote add upstream https://github.com/Scottcjn/homebrew-beacon.git
   ```

### Local Tap Setup (for testing)

To test formulas locally without submitting:

```bash
# Create a local tap
mkdir -p $(brew --repo)/Library/Taps/local
ln -s $(pwd) $(brew --repo)/Library/Taps/local/homebrew-beacon

# Test installation
brew install local/beacon
```

## Contributing Formulas

### Adding a New Formula

1. **Create the formula file** in `Formula/` directory:
   ```bash
   touch Formula/your-formula-name.rb
   ```

2. **Use the template** (see below)

3. **Test locally** before submitting

4. **Submit a Pull Request**

### Formula Template

```ruby
class YourFormulaName < Formula
  desc "Short description of the software"
  homepage "https://github.com/owner/repo"
  url "https://github.com/owner/repo/archive/v1.0.0.tar.gz"
  sha256 "YOUR_SHA256_HASH"
  license "MIT"

  depends_on "go" => :build
  depends_on "node" => :build

  def install
    system "make", "build"
    bin.install "your-binary"
  end

  test do
    system "#{bin}/your-binary", "--version"
  end
end
```

### Updating an Existing Formula

1. Edit the formula file
2. Update `url` and `sha256` for new versions
3. Run `brew fetch --build-from-source ./Formula/your-formula.rb` to verify
4. Test: `brew install ./Formula/your-formula.rb`

## Formula Guidelines

### Naming Conventions

- Use lowercase with hyphens: `beacon-cli`, not `BeaconCLI`
- Match the upstream project name when possible
- Avoid generic names; be specific

### Required Elements

Every formula must include:

| Element | Description |
|---------|-------------|
| `desc` | One-line description (max 80 chars) |
| `homepage` | Project website URL |
| `url` | Source download URL |
| `sha256` | SHA256 checksum of the source |
| `license` | SPDX license identifier |

### Dependencies

Specify build and runtime dependencies:

```ruby
depends_on "go" => :build      # Only needed for building
depends_on "openssl"           # Runtime dependency
depends_on "macos" => :optional # macOS only
```

Common build dependencies:
- `go` => :build
- `node` => :build
- `rust` => :build
- `cmake` => :build

### SHA256 Verification

Always verify the SHA256 hash:

```bash
# For tar.gz files
curl -sL https://example.com/file.tar.gz | sha256sum

# For macOS
shasum -a 256 file.tar.gz
```

## Testing

### Local Formula Testing

```bash
# Syntax check
brew style ./Formula/your-formula.rb

# Install test
brew install --build-from-source ./Formula/your-formula.rb

# Test block execution
brew test ./Formula/your-formula.rb

# Audit for common issues
brew audit --new-formula ./Formula/your-formula.rb
```

### CI Testing

All formulas are tested automatically on:
- macOS (Intel and Apple Silicon)
- Ubuntu Linux

Tests include:
- Formula syntax validation
- Successful compilation
- Test block execution
- Dependency resolution

## Submitting Changes

### Pull Request Process

1. **Update your fork**:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create a feature branch**:
   ```bash
   git checkout -b add-formula-name
   ```

3. **Make your changes** and commit:
   ```bash
   git add Formula/your-formula.rb
   git commit -m "Add formula for YourFormula v1.0.0"
   ```

4. **Push to your fork**:
   ```bash
   git push origin add-formula-name
   ```

5. **Open a Pull Request** on GitHub

### Commit Message Format

```
Add formula for <package-name> v<version>

- Brief description of what the package does
- Any notable dependencies or requirements
- Link to upstream project if relevant
```

Example:
```
Add formula for Beacon CLI v2.1.0

- Agent ping and RTC communication tool
- Requires Go 1.19+ for building
- Includes UDP bus functionality
```

### PR Checklist

Before submitting, verify:

- [ ] Formula follows naming conventions
- [ ] All required elements present (desc, homepage, url, sha256, license)
- [ ] SHA256 verified and correct
- [ ] Local testing passed (`brew install`, `brew test`)
- [ ] `brew audit --new-formula` passes
- [ ] Commit message follows format
- [ ] Single formula per PR (unless related updates)

## Code of Conduct

### Our Standards

- Be respectful and constructive in all interactions
- Welcome newcomers and help them learn
- Focus on what's best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment, discrimination, or intimidation
- Trolling, insulting/derogatory comments
- Personal or political attacks
- Publishing others' private information

### Reporting Issues

If you experience or witness unacceptable behavior:

1. Contact the maintainers directly
2. Include relevant details (dates, screenshots, etc.)
3. All reports will be handled confidentially

## Resources

### Homebrew Documentation

- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Acceptable Formulae](https://docs.brew.sh/Acceptable-Formulae)
- [Ruby Style Guide](https://rubystyle.guide/)

### Beacon Resources

- [Beacon Documentation](https://github.com/Scottcjn/beacon)
- [Issue Tracker](https://github.com/Scottcjn/homebrew-beacon/issues)
- [BCOS Ecosystem](https://github.com/Scottcjn/BCOS.md)

### Getting Help

- **General questions**: Open a GitHub Discussion
- **Bug reports**: Open an issue with the "bug" label
- **Formula requests**: Open an issue with the "formula request" label
- **Security issues**: Email maintainers directly (do not open public issues)

## License

By contributing to homebrew-beacon, you agree that your contributions will be licensed under the same license as the project (see LICENSE file).

---

**Thank you for contributing to the Beacon ecosystem!** 🍺
