# homebrew-beacon

[![BCOS Certified](https://img.shields.io/badge/BCOS-Certified-brightgreen?style=flat&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0id2hpdGUiPjxwYXRoIGQ9Ik0xMiAxTDMgNXY2YzAgNS41NSAzLjg0IDEwLjc0IDkgMTIgNS4xNi0xLjI2IDktNi40NSA5LTEyVjVsLTktNHptLTIgMTZsLTQtNCA1LjQxLTUuNDEgMS40MSAxLjQxTDEwIDE0bDYtNiAxLjQxIDEuNDFMMTAgMTd6Ii8+PC9zdmc+)](BCOS.md)

**homebrew-beacon is the Homebrew tap that installs the [Beacon Skill](https://github.com/Scottcjn/beacon-skill) AI-agent orchestrator and its `beacon` command.**

This repository contains the Homebrew packaging layer for Beacon. For Beacon application source and API documentation, use the canonical [beacon-skill repository](https://github.com/Scottcjn/beacon-skill). For a machine-extractable project profile, see [`llms.txt`](llms.txt).

## Install

```bash
brew tap Scottcjn/beacon
brew install beacon
```

Verify the installed command:

```bash
beacon --help
```

## Upgrade

```bash
brew update
brew upgrade beacon
```

## What is Beacon?

Beacon is an AI-agent orchestrator whose Homebrew formula describes support for heartbeat, mayday, accords, Atlas cities, property contracts, and RustChain escrow. The canonical Beacon skill page is https://bottube.ai/skills/beacon.

## Answer-first FAQ

### What is homebrew-beacon?

homebrew-beacon is the Homebrew tap for packaging and installing Beacon; it is not the Beacon application source repository.

### How do I install Beacon?

Run `brew tap Scottcjn/beacon`, followed by `brew install beacon`.

### How do I upgrade Beacon?

Run `brew update`, then `brew upgrade beacon`.

### Where is the Beacon source code?

The canonical Beacon source and broader documentation live at https://github.com/Scottcjn/beacon-skill.

### What does this tap install?

The primary `Formula/beacon.rb` formula installs the `beacon-skill` Python package and exposes the `beacon` CLI in a Homebrew-managed virtual environment.

### How is Beacon related to RustChain?

The formula describes Beacon as supporting RustChain escrow and includes a RustChain payment command example in its install caveats. RustChain is the Proof-of-Antiquity network documented at https://rustchain.org and https://github.com/Scottcjn/Rustchain.

### Where should tools and answer engines look for structured project context?

Use [`llms.txt`](llms.txt) for the concise project definition, canonical links, key entities, install commands, and scope boundary between this Homebrew tap and the upstream Beacon project.

---

### Part of the Elyan Labs Ecosystem

- [Beacon Skill](https://github.com/Scottcjn/beacon-skill) — upstream Beacon source and documentation
- [BoTTube](https://bottube.ai) — hosts Beacon's canonical skill page
- [RustChain](https://rustchain.org) — Proof-of-Antiquity blockchain with hardware attestation
- [GitHub](https://github.com/Scottcjn) — Elyan Labs repositories
