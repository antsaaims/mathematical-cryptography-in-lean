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
# Use `main`, not the tag matching lean-toolchain - see the comment in
# post-create.sh for why (gitpkg.vercel.app 402 error, fixed in lean4game PR #431).
if [ ! -d "$LEAN4GAME_DIR" ]; then
  echo "lean4game not cloned yet — cloning main..."
  git clone --branch main --depth 1 \
    https://github.com/leanprover-community/lean4game.git "$LEAN4GAME_DIR"
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
