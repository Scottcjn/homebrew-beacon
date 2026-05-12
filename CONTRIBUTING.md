# Contributing

Thanks for helping maintain the Beacon Homebrew tap. This repository distributes
Homebrew formulae, so changes should be small, reproducible, and easy for users
to install.

## Local Setup

Clone the tap:

```bash
git clone https://github.com/Scottcjn/homebrew-beacon.git
cd homebrew-beacon
```

If you have Homebrew available, you can test formula changes locally from the
repository root.

## Formula Guidelines

- Keep formula URLs, checksums, versions, and descriptions accurate.
- Do not commit generated bottles or local Homebrew cache files.
- Prefer minimal changes that update one formula at a time.
- Document any manual verification performed for install or upgrade behavior.

## Validation

For documentation-only changes:

```bash
git diff --check
```

For formula changes, run the relevant Homebrew validation commands where
available, such as:

```bash
brew audit --strict Formula/<formula>.rb
brew install --build-from-source Formula/<formula>.rb
```

Mention if Homebrew is not available in your environment.

## Pull Request Checklist

- Explain what formula or documentation changed.
- Include validation commands and results.
- Link the related issue or bounty, if applicable.
