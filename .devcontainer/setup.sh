#!/bin/bash
set -e

# Install Lean4
export LEAN_VERSION="$(cat lean-toolchain)"
echo "LEAN_VERSION is: $LEAN_VERSION"
curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain $LEAN_VERSION
echo 'export PATH="$HOME/.elan/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.elan/bin:$PATH"

# Build the game (uses cached manifest, downloads Mathlib build cache)
lake build

# Install lean4game
export VITE_LEAN4GAME_SINGLE=true
export VITE_LEAN4GAME_SINGLE_NAME=$(basename "$PWD")
cd ..
git clone https://github.com/leanprover-community/lean4game.git
cd lean4game
npm install
npm run build
