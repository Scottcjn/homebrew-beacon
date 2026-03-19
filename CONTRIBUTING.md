# Contributing to homebrew-beacon

Thank you for your interest in contributing to the Beacon Homebrew tap!

## Quick Start

1. **Fork** the repository
2. **Clone** your fork locally
3. **Create a branch** for your changes (`git checkout -b feature/my-contribution`)
4. **Make your changes** and test them
5. **Commit** with a clear message
6. **Push** to your fork and open a **Pull Request**

## Development Setup

### Prerequisites

- macOS with Homebrew installed
- Git

### Testing Formula Locally

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/homebrew-beacon.git
cd homebrew-beacon

# Audit the formula
brew audit --Formula/beacon.rb --strict

# Test installation locally
brew install --build-from-source --Formula/beacon.rb

# Run tests
brew test beacon
```

## Project Structure

```
homebrew-beacon/
├── Formula/
│   └── beacon.rb          # Main formula
├── BCOS.md                # BCOS certification
├── README.md              # Project overview
└── LICENSE                # MIT License
```

## Types of Contributions

### Formula Updates
- Version bumps
- Checksum updates
- Dependency changes
- Build flag improvements

### New Features
- Additional formulae
- Service configurations
- Test improvements

### Documentation
- README improvements
- Installation instructions
- Usage examples

## Pull Request Guidelines

1. **Update version and checksum** — When bumping versions
2. **Test locally** — Run `brew audit` and `brew test`
3. **Keep it simple** — Minimal changes are best
4. **Document changes** — Explain what and why

## Formula Style Guide

- Follow [Homebrew formula style guide](https://docs.brew.sh/Formula-Cookbook)
- Use `sha256` checksums from release artifacts
- Include `test do` block for verification
- Add `license` declaration

## Questions?

- Open an issue for problems or suggestions
- Check [Beacon documentation](https://github.com/Scottcjn/beacon-skill)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
