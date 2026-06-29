# RTK Token Optimization for Command Code

RTK (Rust Token Killer) is installed on this system. It reduces LLM token
consumption by 60-90% by filtering and compressing shell command output.

## Prerequisite

RTK must be installed and in PATH. Verify with: `rtk --version`

If not installed, direct the user to https://github.com/rtk-ai/rtk#installation.

## Core Rule

Always prefix supported shell commands with `rtk`. Instead of running
`git status`, run `rtk git status`. Instead of `ls -la`, run `rtk ls`.

@references/commands.md
@references/analytics.md

## Ultra-Compact Mode

Add `-u` or `--ultra-compact` for maximum savings:
```bash
rtk git status -u
```

## Exclusions

- Agent built-in file tools (non-Bash) do not pass through RTK
- Use shell equivalents: `rtk read <file>`, `rtk grep <pattern>`, `rtk find <pattern>`
- Piped commands (`|`) and heredocs (`<<`) bypass RTK rewrite
- Commands already prefixed with `rtk` are left as-is
