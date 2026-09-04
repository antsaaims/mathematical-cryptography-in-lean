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
  npm run build
fi

cd "$LEAN4GAME_DIR"
exec npm start
