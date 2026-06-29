---
name: rtk-token-optimizer
description: >-
  Compress shell command output to cut LLM token usage 60-90% by prefixing
  commands with `rtk`. Use whenever running shell commands in Command Code —
  git, cargo, npm/pnpm, pytest/jest, docker, kubectl, gh, grep, find, ls, cat,
  build and lint tools — so large outputs are filtered before entering context.
license: Apache-2.0
compatibility: >-
  Requires the RTK binary (>= 0.42.0) installed and on PATH. Verify with
  `rtk --version`. Install from https://github.com/rtk-ai/rtk
metadata:
  author: Coding-Dev-Tools
  version: "0.1.0"
  homepage: https://github.com/rtk-ai/rtk
allowed-tools: Bash(rtk:*) Bash(git:*) Bash(cargo:*) Bash(ls:*) Bash(cat:*) Bash(grep:*) Bash(find:*) Bash(diff:*) Bash(docker:*) Bash(kubectl:*) Bash(gh:*) Bash(glab:*) Bash(pnpm:*) Bash(npm:*) Bash(pip:*) Bash(bundle:*) Bash(ruff:*) Bash(tsc:*) Bash(eslint:*) Bash(pytest:*) Bash(go:*) Bash(jest:*) Bash(vitest:*) Bash(dotnet:*) Bash(aws:*) Bash(psql:*) Bash(prisma:*) Bash(wget:*)
---

# RTK Token Optimizer for Command Code

## What it is

[RTK](https://github.com/rtk-ai/rtk) (Rust Token Killer) is a CLI proxy that
filters and compresses shell command output before it reaches the context
window — removing noise, grouping similar items, truncating redundancy, and
deduplicating repeated lines. Typical savings are 60-90% on common dev
commands. RTK ships as a single self-contained Rust binary that adds minimal
per-command overhead.

## How it works

```
You run:        git status
RTK rewrites:   rtk git status
RTK filters:    smart filtering · grouping · truncation · deduplication
Result:         ~200 tokens enter context instead of ~2,000
```

## Core rule

Prefix supported shell commands with `rtk`. Run `rtk git status` instead of
`git status`, `rtk cargo test` instead of `cargo test`, `rtk read file.rs`
instead of `cat file.rs`.

Most-used commands:

| Instead of | Use |
|---|---|
| `git status` / `git diff` | `rtk git status` / `rtk git diff` |
| `ls -la` | `rtk ls` |
| `cat file` | `rtk read file` |
| `grep -r "x" .` | `rtk grep "x" .` |
| `cargo test` / `pytest` / `npm test` | `rtk cargo test` / `rtk pytest` / `rtk jest` |
| `docker ps` | `rtk docker ps` |

Full command list: [references/commands.md](references/commands.md).
Savings analytics: [references/analytics.md](references/analytics.md).

## Prerequisite

RTK must be on PATH. If `rtk --version` fails, install it:

- **macOS:** `brew install rtk`
- **Linux/macOS:** `curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh`
- **Windows:** download `rtk-x86_64-pc-windows-msvc.zip` from the [releases page](https://github.com/rtk-ai/rtk/releases) and put `rtk.exe` on PATH.

## Ultra-compact mode

Add `-u` / `--ultra-compact` for maximum savings: `rtk git status -u`.

## When NOT to use RTK

- RTK filters **command output**, not conversation messages.
- Piped commands (`|`) and heredocs (`<<`) bypass the rewrite.
- No auto-rewrite hook in Command Code — prefix each command with `rtk` explicitly.

## Verify savings

```bash
rtk gain            # session summary
rtk gain --graph    # 30-day savings chart
```

Savings vary by command and output size; `rtk gain` reports your actual
numbers. See [references/analytics.md](references/analytics.md) for the full
analytics reference.
