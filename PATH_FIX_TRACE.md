# Grayed-Out Editor / Backslash-Path Trace

Three independent bugs, all in vendored vscode/monaco-vscode-api code pulled
in by `lean4monaco`, combined to make the editor pane permanently blank and
non-interactive ("grayed out execution box"). All three are patched by
`scripts/fix-game-paths.sh`. This file documents each one so they aren't
re-investigated from scratch or "fixed" the wrong way again.

## Bug 1 — backslash paths in vscode's virtual filesystem

### Symptom

```
Unable to write file '\workspace.code-workspace'
Unable to write file '\Tutorial\1.lean'
NoPermissions (FileSystemError): Not allowed
```

This crashes `LeanMonaco.start()`'s workspace setup (and, later, opening a
level's file) with an unhandled promise rejection — no `.catch()` at the
call site in `app.tsx` — so nothing visibly reports the failure; the editor
pane just never becomes interactive.

### Root cause — TWO independent sources, not one

vscode's path/URI code (`vs/base/common/path.js`, `vs/base/common/uri.js`)
joins/formats paths with `\` instead of `/` whenever it thinks it's running
on Windows. Two *separate* flags feed that decision, and both can end up
`true` in this setup even though the virtual filesystem is never actually
OS-native and must always use `/`:

1. **`vs/base/common/process.js`**'s `platform` getter reads the real
   global `process.platform`. In the browser bundle that global comes from
   `vite-plugin-node-polyfills` and reflects the OS of the machine that
   **built/serves** the client. Building/serving on Windows → `'win32'`.
2. **`vs/base/common/platform.js`**'s `isWindows` is a *separate*,
   independently-computed flag. Its Node-like detection branch requires
   `process.versions.node` to be a string (the polyfill's `versions` is
   `{}`, so that branch is skipped), so it falls through to sniffing
   `navigator.userAgent` for `"Windows"` instead. **This means `isWindows`
   is `true` whenever the *player's own browser* runs on Windows** —
   completely independent of what OS built/hosts the game. This is the more
   important of the two: it means any Windows user hitting *any*
   lean4game instance, even one built and hosted cleanly on Linux, trips
   this bug.

`vs/base/common/uri.js` reads `isWindows` from (2) directly and uses it to
decide whether to `win32.join(...)` and to replace `/` with `\` when
computing a path — this is what actually produces the backslash paths that
break the browser's (always-POSIX) virtual filesystem.

### Fix

Patch both flags to be surgical and unconditional, rather than trying to
control what the underlying `process`/`navigator` globals report:

```js
// vs/base/common/process.js — only the platform getter, not env/arch/cwd
get platform() { return 'linux'; }, // was: return process.platform;
```
```js
// vs/base/common/platform.js — forced after all detection branches run
_isWindows = false;
```

### History: what did NOT work, and why

An earlier version of this fix (before this rewrite) only addressed a third,
mostly-irrelevant thing: it added
`define: { "process.platform": JSON.stringify("linux") }` to
`vite.config.ts`, on the theory that `path-browserify` (aliased in for
Node's `path` module in browser code) was the culprit. Two problems:
1. It checked for `vite.config.ts` at the checkout root, but in the
   lean4game monorepo it actually lives at `client/vite.config.ts` (client
   is its own npm workspace) — so the check silently no-op'd and the define
   was never actually applied.
2. Even fixed, the premise was wrong: the installed `path-browserify`
   (1.0.1) is POSIX-only unconditionally and never reads `process.platform`
   at all. A global esbuild `define` for `"process.platform"` is also too
   blunt — it replaces that expression everywhere in the bundle, including
   inside `vite-plugin-node-polyfills`' own process-shim construction, which
   broke `process.env` access elsewhere (`Cannot read properties of
   undefined (reading 'VSCODE_TEXTMATE_DEBUG')`, fully blank page).

Even after fixing the `process.js` platform getter (bug source #1 above)
the crash still reproduced identically, because `platform.js`'s `isWindows`
(source #2) is a completely independent code path that isn't affected by
`process.platform` at all. Both must be patched.

## Bug 2 — `getClientArea` throws before the editor ever mounts

### Symptom

```
Uncaught (in promise) Error: Unable to figure out browser width and height
```
right after `[LeanMonaco]: setting monaco environment`, with
`[LeanMonaco]: done initializing` never printing. Since `app.tsx`'s
`_leanMonaco.start(...)` call has no `.catch()`, this permanently aborts
initialization — the editor never retries.

### Root cause

`monaco-vscode-api`'s default `StandaloneLayoutService`
(`vs/editor/standalone/browser/standaloneLayoutService.js`) falls back to
measuring `document.body` before any editor container exists yet
(`vs/base/browser/dom.js`'s `getClientArea`). That function throws only if
`window.innerWidth`/`innerHeight` *and* `document.body`'s *and*
`document.documentElement`'s client dimensions are all simultaneously
falsy. Confirmed by direct instrumentation that this genuinely happens in
practice at that exact moment (not just in theory).

### Fix

Make the failure recoverable instead of fatal — return a placeholder
dimension instead of throwing:

```js
// vs/base/browser/dom.js, end of getClientArea
return new Dimension(window.screen?.width || 1024, window.screen?.height || 768);
// was: throw new Error('Unable to figure out browser width and height');
```

vscode's layout system relayouts on later resize/container-attach events
regardless, so a temporarily-wrong initial guess is recoverable where a
hard crash is not.

## Bug 3 — infoview (goal state) panel never mounts

### Symptom

```
Uncaught Cannot read properties of undefined (reading 'append')
```
from `lean4monaco`'s `IFrameInfoWebviewFactory.make()`. The goal-state panel
spins forever and never shows the current proof state.

### Root cause

`app.tsx` calls `leanMonaco.setInfoviewElement(infoviewRef.current!)` exactly
once, at top-level mount — but `app.tsx`'s own `infoviewRef` is never
attached to any rendered JSX element (dead code, likely left over from a
refactor). So `leanMonaco.infoviewEl` is always `null`. The *actual* infoview
host `<div>` is rendered inside `level.tsx`'s `ExercisePanel` component, with
its *own*, separate `infoviewRef` — but nothing ever calls
`setInfoviewElement` with that one.

### Fix

`level.tsx`'s `PlayableLevel` component (which owns the real, rendered
`infoviewRef`) now has its own effect wiring it up once `leanMonaco` is
available:
```js
useEffect(() => {
  if (leanMonaco && infoviewRef.current) {
    leanMonaco.setInfoviewElement(infoviewRef.current)
  }
}, [leanMonaco])
```

## Other, independent hardening applied at the same time

- **React StrictMode double-invoking effects** (`client/src/index.tsx`):
  dev-mode StrictMode double-invokes `app.tsx`'s effect that constructs the
  `LeanMonaco` singleton, wasting a full Lean/Monaco boot on every page load
  (lean4monaco disposes the first instance mid-init: "There can only be one
  active LeanMonaco instance at a time"). Fixed by removing `StrictMode`.
- **`htmlElement` left undefined** (`editor-atoms.ts` / `app.tsx`):
  lean4monaco's own README documents overriding `htmlElement` with a real,
  mounted wrapper element; lean4game never did. `app.tsx` now passes a ref
  to its outer `<div className="app">`, matching upstream's documented
  usage (this affects "the extent of certain monaco features such as the
  right-click context menu" per lean4monaco's source comment — not what
  caused bugs 1-3, but no reason to leave it unwired).
- `path.join(...)` → `path.posix.join(...)` in four client `.tsx` files, and
  a `normalizePath()` helper in the relay's `serverProcess.ts`: defense in
  depth for path construction that's actually within this codebase's control
  (as opposed to bugs 1-3, which are all inside vendored vscode code).

## Which checkout actually needs patching

The lean4game monorepo exists in **two** places, and only one of them is
served to the browser:

- `.lake/packages/GameServer` — fetched by `lake build` as this game's Lean
  dependency (`lakefile.lean`'s `require`). Only its `server/` subfolder (the
  Lean macros for `World`/`Level`/etc.) is actually used to compile
  `Game.lean`. Its `client/` is **not** what gets bundled and served.
- `../lean4game` (a sibling directory of this repo) — cloned and built
  separately per
  [`doc/running_locally.md`](https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md);
  `npm install && npm run build`/`npm start` run **here**, so this is the
  checkout that must be patched for the fix to take effect in the running
  game.

`scripts/fix-game-paths.sh` patches `../lean4game` (the one that matters)
and, defensively, `.lake/packages/GameServer` if present (several patterns
don't match there since its `client/` has drifted from the monorepo's
current structure — harmless, since that copy is never served).

## When to Re-run

`scripts/fix-game-paths.sh` must be re-applied whenever `../lean4game` is
freshly cloned (e.g. a new devcontainer/Codespace build) or
`.lake/packages/GameServer` is re-fetched (e.g. after `lake update`). Bugs
1-2's fixes and the `node_modules/vscode` targeting only have an effect
*after* `npm install` has populated `node_modules` (that's where the files
live, and every fresh install replaces them), so this script must also be
re-run right after `npm install`, not only before it.

Both `post-create.sh` and `run-server.sh` call it automatically **twice**:
once after the `../lean4game` clone (before `npm install`), and once again
right after `npm install` (before `npm run build`/`npm start`).

Manual re-run:
```bash
bash scripts/fix-game-paths.sh
```
Safe to run repeatedly — every patch step is idempotent (checks its own
marker/state before editing).

## How to Verify

Load the game in a real (foreground, visible) browser tab, open a level,
type a tactic into the editor/execute box, and submit it — if the editor is
actually mounted, keystrokes appear and submitting produces feedback (a
green checkmark / error message / updated goal state), not silence. Check
the browser console: no `Unable to write file` / `NoPermissions`, no
`Unable to figure out browser width and height`, no `reading 'append'`.

To check the patches landed in the checkout that's actually served:
```bash
grep -n "return 'linux'" ../lean4game/node_modules/vscode/vscode/src/vs/base/common/process.js
grep -n "_isWindows = false;" ../lean4game/node_modules/vscode/vscode/src/vs/base/common/platform.js
grep -n "fix-game-paths] degrade gracefully" ../lean4game/node_modules/vscode/vscode/src/vs/base/browser/dom.js
grep -n "wire up the infoview host element" ../lean4game/client/src/components/level.tsx
```

## Files Changed

- `scripts/fix-game-paths.sh` — automated patcher script; patches `../lean4game`
  (what's actually built and served) and, defensively, `.lake/packages/GameServer`
- `.devcontainer/post-create.sh` — clones `../lean4game` (pinned to `main`)
  if missing, runs the fixer, `npm install`s, runs the fixer again (for the
  node_modules-targeting patches), then builds
- `.devcontainer/run-server.sh` — same clone-then-patch-then-install-then-
  patch-again guard before `npm start`
- `../lean4game/client/src/index.tsx` — `React.StrictMode` removed (applied
  by script at runtime, not tracked in this repo)
- `../lean4game/client/src/app.tsx` — `appRef` wired as LeanMonaco's
  `htmlElement` (applied by script at runtime)
- `../lean4game/client/src/components/level.tsx` — `setInfoviewElement`
  wired to the real, rendered `infoviewRef` (bug 3); `path.posix.join`
  defense-in-depth (applied by script at runtime)
- `../lean4game/client/src/components/landing_page.tsx`,
  `landing_page/tile.tsx`, `infoview/main.tsx` — `path.posix.join`
  defense-in-depth (applied by script at runtime)
- `../lean4game/relay/src/serverProcess.ts` — `normalizePath` helper,
  defense-in-depth for the relay's own (real Node.js) path construction
  (applied by script at runtime)
- `../lean4game/node_modules/vscode/vscode/src/vs/base/common/process.js` —
  hardcoded `platform: 'linux'` (bug 1, source #1) (applied by script at
  runtime, wiped by every fresh `npm install` and must be re-applied after)
- `../lean4game/node_modules/vscode/vscode/src/vs/base/common/platform.js` —
  forced `isWindows = false` (bug 1, source #2 — the one that matters for
  any Windows-browser player) (applied by script at runtime, same
  re-apply-after-install caveat)
- `../lean4game/node_modules/vscode/vscode/src/vs/base/browser/dom.js` —
  `getClientArea` degrades gracefully instead of throwing (bug 2) (applied
  by script at runtime, same re-apply-after-install caveat)
