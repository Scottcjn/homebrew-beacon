# Contributing to homebrew-beacon

Thanks for improving the Homebrew tap for Beacon and ClawRTC. Formula changes
should be easy for Homebrew users to audit, install, and test.

## Setup

1. Fork the repository and create a branch:

   ```sh
   git checkout -b fix/short-description
   ```

2. Tap your local checkout:

   ```sh
   brew tap-new local/beacon-test
   cp Formula/*.rb "$(brew --repository local/beacon-test)/Formula/"
   ```

3. Audit any formula you change:

   ```sh
   brew audit --strict --online local/beacon-test/beacon
   brew audit --strict --online local/beacon-test/clawrtc
   ```

4. Run formula tests where practical:

   ```sh
   brew test local/beacon-test/beacon
   brew test local/beacon-test/clawrtc
   ```

## Pull Request Guidelines

- Keep version bumps, checksum updates, and formula behavior changes in separate
  PRs when possible.
- Include the `brew audit` and `brew test` commands you ran.
- Note the macOS version and CPU architecture used for testing.
- Update `README.md` if installation or upgrade commands change.
- Do not commit Homebrew cache files or local tap metadata.

## Code Style

- Follow standard Homebrew Ruby formula style.
- Keep formula descriptions concise and user-facing.
- Prefer explicit test blocks that verify the installed command works.
- Keep resource blocks sorted and tied to the package version they support.
- Avoid local paths or environment-specific assumptions in formula files.

## Validation Checklist

- [ ] Formula Ruby syntax is valid.
- [ ] `brew audit --strict --online` was run or the limitation is documented.
- [ ] `brew test` was run for changed formulae when practical.
- [ ] README updates match the formula names and tap commands.
- [ ] No local cache or generated files are included.
