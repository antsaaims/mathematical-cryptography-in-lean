# Path Fix Trace — POSIX Forward-Slash Normalization

## Problem

When the Lean game is hosted on Linux/Codespaces (Ubuntu), the frontend virtual
filesystem fails with errors like:

```
Unable to write file '\workspace.code-workspace'
Unable to write file '\UOV\1.lean'
NoPermissions (FileSystemError)
```

## Root Cause

The lean4game monorepo bundles a browser frontend that uses `path-browserify`
as a polyfill for Node's `path` module. This alias is set in `vite.config.ts`
→ `resolve.alias: { path: "path-browserify" }`.

The `path-browserify` library selects its path separator (`\` vs `/`) based on
`process.platform`. When the game is **built** on Windows (`process.platform ===
'win32'`), every `path.join(...)` call in the client bundle produces backslash
paths (e.g. `\UOV\1.lean`). These get embedded into the compiled JavaScript and
shipped to the browser.

On Linux, backslash paths are treated as a single path component starting from
root `/`, so `\UOV\1.lean` resolves to root `/` and triggers `NoPermissions`.

### Correction: which checkout actually needs patching

The lean4game monorepo exists in **two** places, and only one of them is
served to the browser:

- `.lake/packages/GameServer` — fetched by `lake build` as this game's Lean
  dependency (`lakefile.lean`'s `require`). Only its `server/` subfolder (the
  Lean macros for `World`/`Level`/etc.) is actually used to compile
  `Game.lean`. Its `client/` is **not** what gets bundled and served.
- `../lean4game` (a sibling directory of this repo) — cloned and built
  separately per
  [`doc/running_locally.md`](https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md);
  `npm install && npm run build` runs **here**, so this is the checkout that
  must be patched for the fix to take effect in the running game.

An earlier version of this fix patched only `.lake/packages/GameServer`,
which compiles cleanly but has no effect on the browser bundle actually
served — the original error would still occur. `scripts/fix-game-paths.sh`
now patches `../lean4game` (the one that matters) and, defensively,
`.lake/packages/GameServer` if present.

A related bug: nothing in the devcontainer scripts actually **cloned**
`../lean4game` — `post-create.sh` and `run-server.sh` both `cd`'d into it
assuming it already existed. Both scripts now clone it (pinned to the tag in
`lean-toolchain`) before patching and building it. `devcontainer.json` also
never called either script (`postCreateCommand` was just `lake exe cache
get`, and there was no `postStartCommand`), so none of this ran
automatically — see the "Files Changed" section below.

## Key Code Locations

### Client-side (runs in browser — must always use `/`)

| File | What it does | Fix |
|------|-------------|-----|
| `client/src/components/level.tsx` | Constructs `file:///${worldId}/${levelId}` URI (already POSIX) and `path.join("data", gameId, image)` | `path.join` → `path.posix.join` |
| `client/src/components/landing_page.tsx` | `path.join("data", gameId, data.image)` | `path.join` → `path.posix.join` |
| `client/src/components/landing_page/tile.tsx` | `path.join("data", gameId, data.image)` | `path.join` → `path.posix.join` |
| `client/src/components/infoview/main.tsx` | `path.join("data", gameId, image)` | `path.join` → `path.posix.join` |

### Build config

| File | Fix |
|------|-----|
| `vite.config.ts` | Add `define: { "process.platform": JSON.stringify("linux") }` so `path-browserify` always uses POSIX `/` |

### Relay/server-side (runs in Node.js — defense-in-depth)

| File | Fix |
|------|-----|
| `relay/src/serverProcess.ts` | Add `normalizePath()` helper to replace `\` → `/` in `file://` URIs sent to client |

## The Fix

A script at `scripts/fix-game-paths.sh` applies all patches automatically:

1. **vite.config.ts**: Injects `define: { "process.platform": "linux" }` so
   `path-browserify` uses POSIX separators in the browser bundle regardless of
   the build platform.

2. **Client .tsx files**: Replaces `path.join(` with `path.posix.join(` in all
   four client source files that use `path.join`. `path.posix` always uses `/`.

3. **serverProcess.ts**: Adds a `normalizePath()` function that replaces
   backslashes with forward slashes in all `file://` URIs sent from the relay
   server to the client.

## When to Re-run

The fix must be re-applied whenever `../lean4game` is freshly cloned (e.g. a
new devcontainer/Codespace build) or `.lake/packages/GameServer` is
re-fetched (e.g. after `lake update`). Both `post-create.sh` and
`run-server.sh` call it automatically, always **after** the `../lean4game`
clone step and **before** `npm install`/`npm run build`/`npm start`.

Manual re-run:
```bash
bash scripts/fix-game-paths.sh
```

## How to Verify

After patching, check that no `path.join(` (non-posix) calls remain in
client source of the checkout that's actually served (`../lean4game`, not
`.lake/packages/GameServer`):
```bash
rg "path\.join\(" ../lean4game/client/src/components/ \
  --glob "*.tsx" --glob "*.ts"
```
Should return zero results (only `path.posix.join` should appear).

## Files Changed

- `scripts/fix-game-paths.sh` — automated patcher script; patches `../lean4game`
  (what's actually built and served) and, defensively, `.lake/packages/GameServer`
- `.devcontainer/post-create.sh` — clones `../lean4game` (pinned to the
  `lean-toolchain` version tag) if missing, then calls the fixer, then builds
- `.devcontainer/run-server.sh` — same clone-then-patch guard before `npm start`
- `.devcontainer/devcontainer.json` — `postCreateCommand`/`postStartCommand`
  now actually invoke `post-create.sh`/`run-server.sh` (previously
  `postCreateCommand` was just `lake exe cache get` and there was no
  `postStartCommand`, so neither script ever ran automatically)
- `../lean4game/vite.config.ts` — `define` block (applied by script at runtime, not tracked in this repo)
- `../lean4game/client/src/components/level.tsx` — `path.posix.join` (applied by script at runtime)
- `../lean4game/client/src/components/landing_page.tsx` — `path.posix.join` (applied by script at runtime)
- `../lean4game/client/src/components/landing_page/tile.tsx` — `path.posix.join` (applied by script at runtime)
- `../lean4game/client/src/components/infoview/main.tsx` — `path.posix.join` (applied by script at runtime)
- `../lean4game/relay/src/serverProcess.ts` — `normalizePath` helper (applied by script at runtime)
