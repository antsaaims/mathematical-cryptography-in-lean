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
