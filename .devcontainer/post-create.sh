#!/bin/bash
# ─────────────────────────────────────────────────────────────
# postCreateCommand — runs as vscode user (non-blocking).
# Heavy compilation: lake build + lean4game npm build.
# ─────────────────────────────────────────────────────────────
set -ex

export HOME="${HOME:-/home/vscode}"
export PATH="/usr/local/bin:/usr/bin:$HOME/.elan/bin:$PATH"

VSCODE_PWD="$PWD"

echo "=== post-create.sh starting ==="
echo "Node: $(node --version 2>&1)"
echo "npm: $(npm --version 2>&1)"

# ── Fetch prebuilt Mathlib oleans (postCreateCommand previously only did this) ──
lake exe cache get || true

# ── Build the Lean game (uses pre-fetched oleans from cache get) ──
# If cache get failed, this will compile from source (slower but works).
lake build

# ── Clone the lean4game client/relay (npm frontend) next to this repo ──
# `lake build` only fetches the `server` subfolder of leanprover-community/lean4game
# into .lake/packages/GameServer (used to compile the game's Lean library). The
# npm-based client + relay must live in a separate sibling checkout, per
# https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md
#
# Use `main`, not the tag matching lean-toolchain: older tags (including the one
# matching our current toolchain) predate PR #431 (merged 2026-01-08), which fixed
# `npm install` failing with "402 Payment Required" from the now-defunct
# gitpkg.vercel.app service that some transitive dependencies used to fetch
# vscode-lean4 subdirectories. See leanprover-community/lean4game#416.
LEAN4GAME_DIR="$VSCODE_PWD/../lean4game"
if [ ! -d "$LEAN4GAME_DIR" ]; then
  echo "=== Cloning lean4game (main) into $LEAN4GAME_DIR ==="
  git clone --branch main --depth 1 \
    https://github.com/leanprover-community/lean4game.git "$LEAN4GAME_DIR"
fi

# ── Patch lean4game for POSIX path normalization ──
# path-browserify (used by the client bundle) picks separators based on
# process.platform. This patch ensures forward slashes are always used,
# preventing NoPermissions errors on Linux/Codespaces. Must run AFTER the
# clone above: it patches ../lean4game (what actually gets built into the
# served client), not just the .lake/packages/GameServer Lean dependency.
# See PATH_FIX_TRACE.md for full documentation.
bash "$VSCODE_PWD/scripts/fix-game-paths.sh" || true

# ── Install and build lean4game client/server ──
export VITE_LEAN4GAME_SINGLE=true
export VITE_LEAN4GAME_SINGLE_NAME=$(basename "$VSCODE_PWD")

cd "$LEAN4GAME_DIR"
rm -rf node_modules
npm install
npm run build

echo "=== post-create.sh completed ==="
