# Changelog

All notable changes to this integration are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/), and this project aims to adhere
to [Semantic Versioning](https://semver.org/).

## [1.0.1] — 2026-06-30

Follow-up accuracy pass after an independent audit against live upstream
rtk-ai/rtk sources (commits, issues, and the current README).

### Fixed
- Removed all references to a `-u` short form of `--ultra-compact`. RTK's own
  README still documents it, but it was removed from the CLI upstream (it
  collided with `git push -u`) and was never restored — invoking it fails
  outright (RTK [#2369](https://github.com/rtk-ai/rtk/issues/2369), open).
  Every reference now uses the working long form, `--ultra-compact`.
- Corrected the piped-output citation: RTK
  [#1282](https://github.com/rtk-ai/rtk/issues/1282) is a correctness bug
  (RTK can silently substitute its compressed summary for the real content on
  a non-TTY pipe), not an ANSI/decoration issue as previously described. The
  ANSI-codes-on-pipe claim now cites the correct issue, RTK
  [#1409](https://github.com/rtk-ai/rtk/issues/1409) (fixed).
- Synced SKILL.md's "Compatibility & limitations" section with README.md's —
  it was missing the "Native tools" and "Hooks on Windows" bullets.

## [1.0.0] — 2026-06-30

First stable release. The integration is now selective, accurate against the real
RTK command surface, and hardened for agent-harness use.

### Changed
- Reworked from "always prefix every command with `rtk`, use ultra-compact for
  maximum savings" to a **selective, signal-preserving** policy: compress noisy,
  large, low-stakes output; keep full fidelity for diffs, structured/JSON output,
  secrets, small outputs, and files you'll edit.
- Recommend RTK's auto-rewrite hook where supported, and document that `rtk init`
  does not target Command Code yet — so manual prefixing is the working default.
- Optimize for **net** savings (gross minus re-runs and the standing prompt cost);
  trimmed the always-on instruction footprint.

### Fixed
- Removed commands/flags that don't exist in real RTK: `rtk tree`,
  `rtk gain --failures`, `rtk json --keys-only`.
- Corrected `rtk read` vs the native Read tool guidance.
- Softened "lossless" to "signal-preserving" to match RTK's filter-plus-tee
  behavior (full output recovered on failure, not guaranteed lossless).

### Added
- **Harness-safety guidance**: don't wrap streaming/`-f` commands (buffer hang);
  trust the raw exit code for pass/fail; prefer native file/search tools; treat
  `rtk` as optional with a raw fallback when it isn't on PATH.
- **Compatibility & limitations** documentation covering the Command Code hook
  gap, exit-code fidelity, piped-output correctness (RTK
  [#1282](https://github.com/rtk-ai/rtk/issues/1282)), ANSI-on-pipe (RTK
  [#1409](https://github.com/rtk-ai/rtk/issues/1409)), the non-functional `-u`
  short flag (RTK [#2369](https://github.com/rtk-ai/rtk/issues/2369)),
  streaming, and the permission surface.

[1.0.1]: https://github.com/Coding-Dev-Tools/rtk-command-code/releases/tag/v1.0.1
[1.0.0]: https://github.com/Coding-Dev-Tools/rtk-command-code/releases/tag/v1.0.0
