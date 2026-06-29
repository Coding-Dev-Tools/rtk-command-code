#!/usr/bin/env bash
set -euo pipefail

# RTK for Command Code — Installer (Linux/macOS)
#
# Works two ways:
#   - From a cloned repo:  ./install.sh                       (copies sibling files)
#   - Piped from the web:  curl -fsSL <raw>/install.sh | bash (downloads the files)
#
# If the RTK binary is missing, this installer offers to install it for you via
# RTK's official installer, so you don't have to install RTK separately.

REPO_RAW="https://raw.githubusercontent.com/Coding-Dev-Tools/rtk-command-code/main"
RTK_INSTALL_URL="https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh"

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

step()  { printf '  %b=>%b %s\n'     "$CYAN"   "$NC" "$1"; }
ok()    { printf '  %b[OK]%b %s\n'   "$GREEN"  "$NC" "$1"; }
warn()  { printf '  %b[!!]%b %s\n'   "$YELLOW" "$NC" "$1"; }
fail()  { printf '  %b[FAIL]%b %s\n' "$RED"    "$NC" "$1"; exit 1; }

QUIET=false
NO_RTK=false
for arg in "$@"; do
    case "$arg" in
        -h|--help)
            cat <<'EOF'
RTK for Command Code — Installer (Linux/macOS)

Installs RTK token optimization instructions for Command Code CLI, and (if it
is missing) the RTK binary itself.

Usage:
  ./install.sh            Interactive install (from a cloned repo)
  ./install.sh --quiet    Silent install (no prompts; auto-installs RTK)
  ./install.sh --no-rtk   Do not install the RTK binary, only the instructions
  curl -fsSL <raw>/install.sh | bash         Install directly from the web

What it does:
  1. Installs the RTK binary via its official installer if `rtk` is not on PATH
  2. Installs AGENTS.md + references/ to ~/.commandcode/
     (copies sibling files when run from a clone, otherwise downloads them)
  3. Confirms Command Code CLI will read the instructions

Requires:
  - Command Code CLI (cmd, cmdc, or command-code in PATH)
EOF
            exit 0
            ;;
        --quiet)  QUIET=true ;;
        --no-rtk) NO_RTK=true ;;
        *) warn "Unknown option: $arg" ;;
    esac
done

# Ask a yes/no question that still works when this script is itself piped to
# bash via stdin (curl | bash) — in that case stdin is the script, so read from
# the controlling terminal instead. $2 is the default ("y" or "n").
confirm() {
    local prompt="$1" default="${2:-n}" reply
    $QUIET && { [[ "$default" == "y" ]]; return; }
    if [[ -r /dev/tty ]]; then
        read -r -p "$prompt " reply </dev/tty || reply=""
        [[ -z "$reply" ]] && reply="$default"
        [[ "$reply" == "y" || "$reply" == "Y" ]]
    else
        # Non-interactive (piped) and not quiet: fall back to the default.
        [[ "$default" == "y" ]]
    fi
}

install_rtk() {
    step "Installing the RTK binary (RTK's official installer)..."
    if command -v curl &>/dev/null; then
        curl -fsSL "$RTK_INSTALL_URL" | sh || warn "RTK installer reported an error."
    elif command -v wget &>/dev/null; then
        wget -qO- "$RTK_INSTALL_URL" | sh || warn "RTK installer reported an error."
    else
        warn "Need curl or wget to install RTK."
        return
    fi
    if command -v rtk &>/dev/null; then
        ok "RTK installed: $(rtk --version)"
    else
        warn "RTK was installed but is not on this shell's PATH yet."
        warn "Open a new shell, or see https://github.com/rtk-ai/rtk#installation"
    fi
}

# --- Step 1: Check prerequisites ---
step "Checking prerequisites..."

if command -v cmd &>/dev/null || command -v cmdc &>/dev/null || command -v command-code &>/dev/null; then
    ok "Command Code CLI found"
else
    warn "Command Code CLI not found in PATH."
    warn "Install it first: npm install -g command-code"
fi

if command -v rtk &>/dev/null; then
    ok "RTK found: $(rtk --version)"
elif $NO_RTK; then
    warn "RTK not found (--no-rtk set). Install later: https://github.com/rtk-ai/rtk#installation"
else
    warn "RTK not found in PATH."
    if confirm "Install RTK now? (Y/n)" y; then
        install_rtk
    else
        warn "Skipped RTK install. Install later: https://github.com/rtk-ai/rtk#installation"
    fi
fi

# --- Step 2: Locate the script's own directory (empty when piped via stdin) ---
SCRIPT_DIR=""
if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]:-}" ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

AGENTS_DIR="$HOME/.commandcode"
REF_DIR="$AGENTS_DIR/references"
mkdir -p "$REF_DIR"

fetch() {
    # fetch <relative-path> <dest>
    if command -v curl &>/dev/null; then
        curl -fsSL "$REPO_RAW/$1" -o "$2"
    elif command -v wget &>/dev/null; then
        wget -qO "$2" "$REPO_RAW/$1"
    else
        fail "Need curl or wget to download $1 (or run from a cloned repo)."
    fi
}

# --- Step 3: Install AGENTS.md + references ---
if [[ -n "$SCRIPT_DIR" && -f "$SCRIPT_DIR/AGENTS.md" ]]; then
    step "Installing instructions from local files..."
    cp "$SCRIPT_DIR/AGENTS.md"               "$AGENTS_DIR/AGENTS.md" || fail "Could not copy AGENTS.md"
    cp "$SCRIPT_DIR/references/commands.md"  "$REF_DIR/commands.md"  || fail "Could not copy references/commands.md"
    cp "$SCRIPT_DIR/references/analytics.md" "$REF_DIR/analytics.md" || fail "Could not copy references/analytics.md"
else
    step "Downloading instructions from GitHub..."
    fetch "AGENTS.md"               "$AGENTS_DIR/AGENTS.md"
    fetch "references/commands.md"  "$REF_DIR/commands.md"
    fetch "references/analytics.md" "$REF_DIR/analytics.md"
fi

# --- Step 4: Verify ---
step "Verifying installation..."
for f in "$AGENTS_DIR/AGENTS.md" "$REF_DIR/commands.md" "$REF_DIR/analytics.md"; do
    [[ -s "$f" ]] || fail "Missing or empty after install: $f"
done
grep -q "RTK" "$AGENTS_DIR/AGENTS.md" || fail "AGENTS.md does not contain RTK instructions"
ok "Installed AGENTS.md + references/ to $AGENTS_DIR"

# --- Done ---
printf '\n%bInstallation complete!%b\n\n' "$GREEN" "$NC"
echo "  Command Code CLI will now inject RTK instructions into every session."
echo "  Restart any active Command Code sessions to apply."
echo ""
echo "  Verify: rtk gain"
echo ""
