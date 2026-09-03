#!/usr/bin/env bash
set -euo pipefail

# 1. Install elan non-interactively
if ! command -v elan &> /dev/null; then
    curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --default-toolchain none
fi

# Ensure elan is available in PATH for current script execution
export PATH="$HOME/.elan/bin:$PATH"

# 2. Fetch toolchain binary specified in lean-toolchain
if [ -f "lean-toolchain" ]; then
    elan toolchain install "$(cat lean-toolchain)"
    elan default "$(cat lean-toolchain)"
fi
