#!/bin/bash
# ─────────────────────────────────────────────────────────────
# postStartCommand — runs as vscode user after post-create.
# Starts the lean4game server.
# ─────────────────────────────────────────────────────────────
set -ex

export HOME="${HOME:-/home/vscode}"
export PATH="/usr/local/bin:/usr/bin:$HOME/.elan/bin:$PATH"

export VITE_LEAN4GAME_SINGLE=true
export VITE_LEAN4GAME_SINGLE_NAME=$(basename "$PWD")

echo "=== run-server.sh starting ==="
echo "Node: $(node --version 2>&1)"

# Wait for post-create.sh to finish building (if still running)
GAME_DIR="$PWD"
LEAN4GAME_DIR="$GAME_DIR/../lean4game"

# Clone lean4game if post-create.sh hasn't run yet (e.g. manual invocation).
# Pin to commit 7f6e045 (PR #431, "replace gitpkg.vercel.app dependencies"),
# NOT `main` and NOT the v4.23.0 tag. The tag predates PR #431 and still hits
# the dead gitpkg.vercel.app dependency (402 error). `main` has the fix but
# has since been through three Lean toolchain bumps (v4.26.0/v4.28/v4.29.1/
# v4.31.0) that our pinned .lake/packages/GameServer (also at the v4.23.0-era
# commit) doesn't speak — that skew is what made `$/lean/rpc/connect` hang
# forever (diagnostics kept working since that's core LSP, but the
# GameServer-specific widget/rpc protocol had drifted). Commit 7f6e045 is the
# single commit with the gitpkg fix from BEFORE the first toolchain bump
# (76e7d7f, 7 hours later) — the one point in history compatible with both.
# See PATH_FIX_TRACE.md for details.
if [ ! -d "$LEAN4GAME_DIR" ]; then
  echo "lean4game not cloned yet — fetching pinned commit 7f6e045..."
  git init "$LEAN4GAME_DIR"
  git -C "$LEAN4GAME_DIR" remote add origin https://github.com/leanprover-community/lean4game.git
  git -C "$LEAN4GAME_DIR" fetch --depth 1 origin 7f6e04520cfce9fd19c649af718c36ea04ea1a0e
  git -C "$LEAN4GAME_DIR" checkout FETCH_HEAD
fi

# ── Patch lean4game for POSIX path normalization ──
# Must run AFTER the clone above: it patches ../lean4game (what actually
# gets built into the served client), not just the .lake/packages/GameServer
# Lean dependency. See PATH_FIX_TRACE.md for details.
bash "$GAME_DIR/scripts/fix-game-paths.sh" || true

# Check if lean4game has been built; if not, build it now
if [ ! -f "$LEAN4GAME_DIR/client/dist/index.html" ]; then
  echo "lean4game not built yet — building now..."
  cd "$LEAN4GAME_DIR"
  rm -rf node_modules
  npm install

  # Re-run the path patch now that node_modules exists: one of the patches
  # targets node_modules/vscode directly (the load-bearing fix for the
  # backslash-path crash) and has no effect until npm install has run.
  bash "$GAME_DIR/scripts/fix-game-paths.sh" || true

  npm run build
fi

cd "$LEAN4GAME_DIR"
# The relay (relay/src/index.ts) does `const PORT = process.env.PORT || 8080`
# — if a `PORT` env var happens to be set (e.g. by a preview/launch harness
# that injects PORT to match the app's advertised port, which here is 3000,
# the client's port, not the relay's), the relay tries to bind the same
# port the client's vite dev server already owns and crashes with
# EADDRINUSE instead of falling back to its own default of 8080. Unset it
# so the relay always uses its real port regardless of what invoked this
# script; the client's own port (3000) comes from its own vite config, not
# this env var, so this is safe.
unset PORT
exec npm start
