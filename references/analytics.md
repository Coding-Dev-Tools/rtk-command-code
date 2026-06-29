# RTK Analytics

Quantify token savings with `rtk gain`, and find more opportunities with
`rtk discover`. This is the canonical analytics reference (command rewrites
live in [commands.md](commands.md)).

| Command | Description |
|---|---|
| `rtk gain` | Session summary: tokens saved, efficiency meter |
| `rtk gain --graph` | ASCII bar chart of daily savings (last 30 days) |
| `rtk gain --history` | Recent command history with per-command savings |
| `rtk gain --daily` | Day-by-day breakdown |
| `rtk gain --weekly` | Weekly breakdown |
| `rtk gain --monthly` | Monthly breakdown |
| `rtk gain --all --format json` | JSON export for dashboards |
| `rtk gain --quota` | Monthly quota savings estimate |
| `rtk gain --failures` | Commands that bypassed RTK (parse-failure log) |
| `rtk gain --reset --yes` | Reset all saved-token counters to zero |
| `rtk discover` | Find commands that could benefit from RTK |
| `rtk discover --all --since 7` | All projects, last 7 days |
| `rtk session` | RTK adoption across recent sessions |

Run `rtk gain` periodically to quantify actual savings; numbers vary by
command and output size.
