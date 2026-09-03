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

# ── Build the Lean game (uses pre-fetched oleans from cache get) ──
# This should be fast since Mathlib oleans were downloaded in setup.sh.
# If cache get failed, this will compile from source (slower but works).
lake build

# ── Install and build lean4game client/server ──
export VITE_LEAN4GAME_SINGLE=true
export VITE_LEAN4GAME_SINGLE_NAME=$(basename "$VSCODE_PWD")

cd "$VSCODE_PWD/../lean4game"
rm -rf node_modules
npm install
npm run build

echo "=== post-create.sh completed ==="
