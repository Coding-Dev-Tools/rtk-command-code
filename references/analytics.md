# RTK Analytics — measure *net* savings, not just gross

`rtk gain` reports **gross** tokens saved. The number that actually matters is
**net**: gross savings minus (a) tokens spent re-running commands when a
compressed view hid something, and (b) the standing cost of these instructions in
context. Optimize for net.

| Command | Use it to |
|---|---|
| `rtk gain` | session summary: tokens saved, efficiency |
| `rtk gain --graph` | 30-day savings trend |
| `rtk gain --history` | per-command savings — see where RTK actually pays off |
| `rtk gain --failures` | commands RTK **couldn't parse** and passed through raw |
| `rtk discover` | find *good* new opportunities (don't blanket-apply) |
| `rtk session` | RTK adoption across recent sessions |
| `rtk gain --all --format json` | export for dashboards (run raw if you'll parse it) |

## Reading the signal

- **High `--history` savings on noisy commands** → working as intended; keep going.
- **Entries in `--failures`** → RTK fell back to raw output for those, so they
  aren't saving — and may be a poor fit (structured or edge-case commands). Run
  them raw and stop wrapping them.
- **You re-ran a command raw right after its `rtk` version** → that pair was a net
  *loss*. Note the command type and stop compressing it.
- **`rtk discover`** surfaces high-volume, noisy commands worth wrapping — a far
  better guide than wrapping everything by reflex.

Savings vary by command and output size; let `rtk gain` show your real numbers
rather than assuming the headline 60–90%.
