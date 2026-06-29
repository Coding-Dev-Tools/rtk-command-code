# RTK Command Reference

Always use `rtk <command>` instead of the bare command. RTK applies four
filter strategies per command type: smart filtering, grouping, truncation,
and deduplication.

## Git
| Instead of | Use |
|---|---|
| `git status` | `rtk git status` |
| `git diff` | `rtk git diff` |
| `git log -n 10` | `rtk git log -n 10` |
| `git add .` | `rtk git add .` |
| `git commit -m "msg"` | `rtk git commit -m "msg"` |
| `git push` | `rtk git push` |
| `git pull` | `rtk git pull` |

## Files
| Instead of | Use |
|---|---|
| `ls -la` | `rtk ls` |
| `tree` | `rtk tree` |
| `cat file.rs` | `rtk read file.rs` |
| `cat file.rs` (aggressive) | `rtk read file.rs -l aggressive` |
| `cat file.rs` (2-line summary) | `rtk smart file.rs` |
| `grep -r "pattern" .` | `rtk grep "pattern" .` |
| `find . -name "*.rs"` | `rtk find "*.rs" .` |
| `diff file1 file2` | `rtk diff file1 file2` |
| `wc -l file` | `rtk wc file` |
| `curl <url>` | `rtk curl <url>` |
| `wget <url>` | `rtk wget <url>` |

## Test Runners
| Instead of | Use |
|---|---|
| `cargo test` | `rtk cargo test` |
| `pytest` | `rtk pytest` |
| `go test` | `rtk go test` |
| `npm test` / `jest` | `rtk jest` |
| `vitest` | `rtk vitest` |
| `playwright test` | `rtk playwright test` |
| `rspec` | `rtk rspec` |
| `rake test` | `rtk rake test` |
| `<any test cmd>` (generic) | `rtk test <cmd>` |
| `<any cmd>` (errors only) | `rtk err <cmd>` |

## Build & Lint
| Instead of | Use |
|---|---|
| `cargo build` | `rtk cargo build` |
| `cargo clippy` | `rtk cargo clippy` |
| `ruff check .` | `rtk ruff check` |
| `tsc --noEmit` | `rtk tsc` |
| `eslint .` | `rtk lint` |
| `next build` | `rtk next build` |
| `golangci-lint run` | `rtk golangci-lint run` |
| `rubocop` | `rtk rubocop` |
| `prettier --check .` | `rtk prettier --check .` |

## Containers
| Instead of | Use |
|---|---|
| `docker ps` | `rtk docker ps` |
| `docker images` | `rtk docker images` |
| `docker logs <container>` | `rtk docker logs <container>` |
| `docker compose ps` | `rtk docker compose ps` |
| `kubectl get pods` | `rtk kubectl pods` |
| `kubectl get services` | `rtk kubectl services` |
| `kubectl logs <pod>` | `rtk kubectl logs <pod>` |

## GitHub CLI
| Instead of | Use |
|---|---|
| `gh pr list` | `rtk gh pr list` |
| `gh pr view 42` | `rtk gh pr view 42` |
| `gh issue list` | `rtk gh issue list` |
| `gh run list` | `rtk gh run list` |
| `glab mr list` | `rtk glab mr list` |

## AWS
| Instead of | Use |
|---|---|
| `aws sts get-caller-identity` | `rtk aws sts get-caller-identity` |
| `aws ec2 describe-instances` | `rtk aws ec2 describe-instances` |
| `aws lambda list-functions` | `rtk aws lambda list-functions` |
| `aws logs get-log-events` | `rtk aws logs get-log-events` |

## Databases
| Instead of | Use |
|---|---|
| `psql ...` | `rtk psql ...` |
| `prisma generate` | `rtk prisma generate` |

## Package Managers
| Instead of | Use |
|---|---|
| `pnpm list` | `rtk pnpm list` |
| `pip list` | `rtk pip list` |
| `pip list --outdated` | `rtk pip outdated` |
| `bundle install` | `rtk bundle install` |

## Data & Utilities
| Instead of | Use |
|---|---|
| `<any cmd>` (heuristic summary) | `rtk summary <cmd>` |
| `<json file>` (structure only) | `rtk json config.json` |
| `<json file>` (keys only) | `rtk json config.json --keys-only` |
| `<cmd>` (raw, for debugging) | `rtk proxy <cmd>` |
| `cat deps.txt` | `rtk deps` |
| `env` (filter sensitive vars) | `rtk env -f AWS` |
| `cat app.log` | `rtk log app.log` |
| `dotnet build` | `rtk dotnet build` |

## Analytics

Analytics commands (`rtk gain`, `rtk discover`, `rtk session`) live in the
canonical [analytics.md](analytics.md) reference.
