#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# fix-game-paths.sh — Normalize GameServer path handling to POSIX forward slashes
#
# PURPOSE:
#   The lean4game frontend uses `path-browserify` as a browser polyfill for
#   Node's `path` module (via vite.config.ts alias). `path-browserify` selects
#   `\` vs `/` based on `process.platform`. When the game is built or run on
#   Windows, `process.platform === 'win32'`, so all `path.join(...)` calls in
#   client code produce backslash paths like `\UOV\1.lean` instead of
#   `UOV/1.lean`.
#
#   On Linux/Codespaces this causes:
#     - "Unable to write file '\workspace.code-workspace'"
#     - "Unable to write file '\UOV\1.lean'"
#     - NoPermissions (FileSystemError)
#
#   This script forces POSIX forward-slash paths everywhere, regardless of
#   build platform.
#
# WHICH CHECKOUT TO PATCH:
#   The lean4game monorepo is present in (up to) two places, and only one of
#   them is actually served to the browser:
#     - `.lake/packages/GameServer` — fetched by `lake build` as a Lean
#       dependency (via lakefile.lean's `require`). Only its `server/`
#       subfolder (the Lean macros for World/Level/etc.) is used to compile
#       Game.lean. Its `client/` is NOT what gets built into the served bundle.
#     - `../lean4game` (sibling of this repo) — cloned separately per
#       doc/running_locally.md; THIS is where `npm install && npm run build`
#       actually runs, so THIS is what must be patched for the fix to take
#       effect in the running game.
#   We patch both when present: the sibling checkout because it's the one
#   that matters, and .lake/packages/GameServer defensively in case any
#   tooling ever builds directly from it.
#
# TRACE: See PATH_FIX_TRACE.md for full documentation of this fix.
#
# USAGE:
#   bash scripts/fix-game-paths.sh
#
#   Called automatically by .devcontainer/post-create.sh and run-server.sh,
#   after the ../lean4game clone exists and before `npm install`/`npm start`.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

patch_dir() {
  local GS_DIR="$1"

  echo "[fix-game-paths] Patching $GS_DIR ..."

  # 1. vite.config.ts: Force process.platform to 'linux' so path-browserify
  #    always uses POSIX forward slashes.
  local VITE_CONFIG="$GS_DIR/vite.config.ts"
  if [ -f "$VITE_CONFIG" ]; then
    if ! grep -q 'fix-game-paths' "$VITE_CONFIG"; then
      sed -i '/base: "\/",/a\
  // [fix-game-paths] Force POSIX forward-slash paths in browser bundle regardless of build platform.\
  // Without this, path-browserify uses process.platform to pick separators,\
  // producing backslash paths when built on Windows, which fails on Linux/Codespaces.\
  define: {\
    "process.platform": JSON.stringify("linux"),\
  },' "$VITE_CONFIG"
      echo "[fix-game-paths]   OK vite.config.ts: added define(process.platform=linux)"
    else
      echo "[fix-game-paths]   SKIP vite.config.ts: already patched"
    fi
  fi

  # 2. Client .tsx files: Replace path.join(...) with path.posix.join(...)
  local FILE TARGET
  for FILE in \
    "client/src/components/level.tsx" \
    "client/src/components/landing_page.tsx" \
    "client/src/components/landing_page/tile.tsx" \
    "client/src/components/infoview/main.tsx"
  do
    TARGET="$GS_DIR/$FILE"
    if [ -f "$TARGET" ]; then
      if grep -q 'path\.join(' "$TARGET" && ! grep -q 'path\.posix\.join(' "$TARGET"; then
        sed -i 's/path\.join(/path.posix.join(/g' "$TARGET"
        echo "[fix-game-paths]   OK $FILE: path.join -> path.posix.join"
      else
        echo "[fix-game-paths]   SKIP $FILE: already patched or no path.join found"
      fi
    fi
  done

  # 3. relay/src/serverProcess.ts: Add normalizePath helper
  local RELAY="$GS_DIR/relay/src/serverProcess.ts"
  if [ -f "$RELAY" ]; then
    if ! grep -q 'fix-game-paths' "$RELAY"; then
      # Add normalizePath helper after the line "import path from 'path';"
      sed -i "/^import path from 'path';\$/a\\
\\
// [fix-game-paths] Normalize backslashes to forward slashes for cross-platform compatibility.\\
// When the relay runs on Windows, path.join produces backslash paths which break\\
// the frontend virtual filesystem on Linux/Codespaces. This ensures all URIs\\
// sent to the client use POSIX forward slashes.\\
function normalizePath(p: string): string {\\
  return p.replace(/\\\\\\\\/g, '/');\\
}" "$RELAY"

      # Wrap replaceUri calls to normalize the URI
      sed -i 's|replaceUri(message, `file://${gameDir}/Game/Metadata.lean`)|replaceUri(message, normalizePath(`file://${gameDir}/Game/Metadata.lean`))|g' "$RELAY"

      # Normalize the return value of getGameDir
      sed -i 's|^    return game_dir;|    // [fix-game-paths] Normalize backslashes to forward slashes so that all|' "$RELAY"
      sed -i '/\[fix-game-paths\] Normalize backslashes to forward slashes so that all/a\    // downstream path constructions and file:// URIs are POSIX-compliant.\n    return normalizePath(game_dir);' "$RELAY"

      # Use path.posix for URI parsing in messageTranslation
      sed -i 's|const pathParts = path.parse(uri.pathname)|const pathParts = path.posix.parse(uri.pathname)|' "$RELAY"
      sed -i 's|worldId = path.basename(pathParts.dir)|worldId = path.posix.basename(pathParts.dir)|' "$RELAY"

      echo "[fix-game-paths]   OK relay/src/serverProcess.ts: added normalizePath + path.posix"
    else
      echo "[fix-game-paths]   SKIP relay/src/serverProcess.ts: already patched"
    fi
  fi
}

PATCHED_ANY=0

# The checkout that is actually built and served to the browser.
LEAN4GAME_SIBLING="$REPO_ROOT/../lean4game"
if [ -d "$LEAN4GAME_SIBLING" ]; then
  patch_dir "$(cd "$LEAN4GAME_SIBLING" && pwd)"
  PATCHED_ANY=1
fi

# Defensive: patch the lake-fetched copy too, in case anything ever builds
# the client directly from .lake/packages/GameServer.
GS_DIR="$REPO_ROOT/.lake/packages/GameServer"
if [ -d "$GS_DIR" ]; then
  patch_dir "$GS_DIR"
  PATCHED_ANY=1
fi

if [ "$PATCHED_ANY" -eq 0 ]; then
  echo "[fix-game-paths] Neither ../lean4game nor .lake/packages/GameServer found yet - nothing to patch."
  exit 0
fi

echo "[fix-game-paths] Done. All paths normalized to POSIX forward slashes."
echo "[fix-game-paths] See PATH_FIX_TRACE.md for details."
