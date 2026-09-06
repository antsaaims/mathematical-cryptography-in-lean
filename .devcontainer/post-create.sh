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
# Pin to commit 7f6e045 (PR #431, "replace gitpkg.vercel.app dependencies"),
# NOT `main` and NOT the v4.23.0 tag matching our toolchain. The tag predates
# PR #431 and still hits the dead gitpkg.vercel.app dependency ("402 Payment
# Required" — see leanprover-community/lean4game#416). `main` has that fix
# but has since been through three Lean toolchain bumps (v4.26.0/v4.28/
# v4.29.1/v4.31.0) that our pinned .lake/packages/GameServer (also frozen at
# the v4.23.0-era commit) doesn't speak — that protocol skew is what made the
# in-game goal panel's `$/lean/rpc/connect` hang forever (core LSP diagnostics
# kept working fine since that part of the protocol is stable; only the
# GameServer-specific widget/rpc layer had drifted). Commit 7f6e045 is the
# single commit with the gitpkg fix from BEFORE the first toolchain bump
# (76e7d7f, merged 7 hours later) — the one point in lean4game's history
# compatible with both the fix and our pinned GameServer. See
# PATH_FIX_TRACE.md for the full diagnosis.
LEAN4GAME_DIR="$VSCODE_PWD/../lean4game"
if [ ! -d "$LEAN4GAME_DIR" ]; then
  echo "=== Fetching lean4game pinned commit 7f6e045 into $LEAN4GAME_DIR ==="
  git init "$LEAN4GAME_DIR"
  git -C "$LEAN4GAME_DIR" remote add origin https://github.com/leanprover-community/lean4game.git
  git -C "$LEAN4GAME_DIR" fetch --depth 1 origin 7f6e04520cfce9fd19c649af718c36ea04ea1a0e
  git -C "$LEAN4GAME_DIR" checkout FETCH_HEAD
fi

# ── Patch lean4game for POSIX path normalization ──
# vscode's own internal path utilities pick separators based on
# process.platform. This patch ensures forward slashes are always used,
# preventing NoPermissions errors. Must run AFTER the clone above: it patches
# ../lean4game (what actually gets built into the served client), not just
# the .lake/packages/GameServer Lean dependency.
# See PATH_FIX_TRACE.md for full documentation.
bash "$VSCODE_PWD/scripts/fix-game-paths.sh" || true

# ── Install and build lean4game client/server ──
export VITE_LEAN4GAME_SINGLE=true
export VITE_LEAN4GAME_SINGLE_NAME=$(basename "$VSCODE_PWD")

cd "$LEAN4GAME_DIR"
rm -rf node_modules
npm install

# ── Re-run the path patch now that node_modules exists ──
# One of the patches targets node_modules/vscode directly (the load-bearing
# fix for the backslash-path crash), so it has no effect until npm install
# has populated node_modules. Re-running is safe/idempotent for the other
# patches (they just report SKIP already-patched).
bash "$VSCODE_PWD/scripts/fix-game-paths.sh" || true

npm run build

echo "=== post-create.sh completed ==="
