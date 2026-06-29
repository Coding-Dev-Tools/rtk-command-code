# Contributing to RTK for Command Code

Thanks for your interest in improving this integration. It teaches
[Command Code CLI](https://commandcode.ai) to route shell commands through
[RTK](https://github.com/rtk-ai/rtk) for 60-90% token savings.

## What's in this repo

This is a documentation-and-installer project — there is no compiled code:

- `SKILL.md` — the on-demand skill definition.
- `AGENTS.md` — always-on memory that `@import`s the references below.
- `references/commands.md` — canonical RTK command-rewrite reference.
- `references/analytics.md` — canonical `rtk gain` / `discover` reference.
- `install.sh`, `install.ps1` — installers for macOS/Linux and Windows.

## Ways to contribute

- Add or correct RTK command mappings in `references/commands.md`.
- Improve installer reliability or platform coverage.
- Clarify the docs in `README.md`, `SKILL.md`, or `AGENTS.md`.

## Ground rules

- **Line endings.** `.gitattributes` enforces LF everywhere except `*.ps1`
  (CRLF). Never commit CRLF in shell scripts or Markdown — it breaks bash
  shebangs and heredocs. If your editor rewrites endings, run
  `git add --renormalize .` before committing.
- **Keep the skill spec-compliant.** `SKILL.md` must retain its YAML
  frontmatter with `name:` and `description:`. CI validates this.
- **Keep references in sync.** Command rewrites live in
  `references/commands.md`; analytics commands live in
  `references/analytics.md`. Don't duplicate tables across files.

## Testing locally

The same checks CI runs:

```bash
bash -n install.sh                    # syntax-check the installer
grep -E '^(name|description):' SKILL.md   # confirm required frontmatter
```

If you touched an installer, run it end to end:

```bash
./install.sh --quiet --no-rtk   # macOS/Linux  (drop --no-rtk to test RTK auto-install)
.\install.ps1 -Quiet -NoRtk     # Windows      (drop -NoRtk to test RTK auto-install)
```

## Submitting a pull request

1. Fork and create a feature branch.
2. Make a focused change with clear commit messages.
3. Confirm CI passes (installer lint + `SKILL.md` / `AGENTS.md` validation).
4. Open a PR describing what changed and why.

## Upstream

This integration is intended to be submittable to
[rtk-ai/rtk](https://github.com/rtk-ai/rtk) to add Command Code CLI as a
supported agent. Please keep changes compatible with that goal.

## License

By contributing, you agree that your contributions are licensed under the
[Apache License 2.0](LICENSE).
