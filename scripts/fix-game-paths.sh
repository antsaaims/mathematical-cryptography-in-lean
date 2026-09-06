#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# fix-game-paths.sh — Normalize GameServer path handling to POSIX forward slashes
#
# PURPOSE:
#   vscode's own internal path utilities (vs/base/common/path.js, used by the
#   monaco-vscode-api workbench that lean4monaco embeds) branch on
#   `process.platform` to decide whether to join paths with `\` or `/`. That
#   `platform` value is read from the real global `process` object (see
#   vs/base/common/process.js), which in the browser bundle comes from
#   vite-plugin-node-polyfills and reflects the OS of the machine that BUILT
#   or is SERVING the bundle. When the game is built/served on Windows,
#   `process.platform === 'win32'`, so vscode's internal Uri/path handling
#   produces backslash paths like `\workspace.code-workspace` and
#   `\UOV\1.lean` instead of `/workspace.code-workspace` and `UOV/1.lean`.
#
#   The browser's virtual filesystem (vscode's FileServiceOverride) always
#   expects POSIX-style paths regardless of host OS, so backslash paths cause:
#     - "Unable to write file '\workspace.code-workspace'"
#     - "Unable to write file '\UOV\1.lean'"
#     - NoPermissions (FileSystemError)
#   This is not Windows-vs-Linux specific: it happens whenever the machine
#   building/serving the client is Windows, whether the browser opening it is
#   on Windows, Linux, or Codespaces — because vscode's internal path code
#   always needs POSIX separators for its `file://` URIs, never OS-native ones.
#
#   NOTE ON HISTORY: an earlier version of this script tried to fix this by
#   adding `define: { "process.platform": JSON.stringify("linux") }` to
#   vite.config.ts, on the theory that `path-browserify` (aliased in place of
#   Node's `path` module for browser code) was the thing branching on
#   `process.platform`. Two things were wrong with that:
#     1. It checked for vite.config.ts at the checkout root, but in the
#        lean4game monorepo it actually lives at `client/vite.config.ts`
#        (client is its own npm workspace) — so the check silently no-op'd
#        and the define was never actually applied to the served bundle.
#     2. Even with the path fixed, the premise was wrong: the installed
#        `path-browserify` (1.0.1) is POSIX-only already and never reads
#        `process.platform` at all. A global esbuild `define` for
#        `"process.platform"` is also too blunt — it textually replaces every
#        occurrence of that expression across the whole bundle, including
#        inside vite-plugin-node-polyfills' own process shim construction,
#        which broke `process.env` access elsewhere (observed as
#        "Cannot read properties of undefined (reading 'VSCODE_TEXTMATE_DEBUG')"
#        and a fully blank page).
#   The actual fix targets vscode's own internal process shim directly (see
#   step 3 below), which is surgical (only touches `platform`, not `env`).
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
#   Called automatically by .devcontainer/post-create.sh and run-server.sh.
#   Steps 1-2 target checked-out source and must run before `npm install`/
#   `npm start` (their normal call site, after the ../lean4game clone).
#   Step 3 targets a file inside `node_modules/vscode`, so it only has an
#   effect once `npm install` has run — post-create.sh and run-server.sh also
#   call this script again after `npm install` to cover that.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Literal (non-regex) find-and-replace of $2's content with $3's content inside
# file $1. Used for patches too large/quote-heavy for a sed one-liner. Prints
# REPLACED or NOTFOUND (caller checks this to report OK/WARN).
literal_replace_file() {
  local TARGET="$1" OLD_CONTENT_FILE="$2" NEW_CONTENT_FILE="$3"
  perl -0777 -e '
    my ($target, $oldf, $newf) = @ARGV;
    open(my $tfh, "<", $target) or die $!;
    local $/; my $content = <$tfh>; close $tfh;
    open(my $ofh, "<", $oldf) or die $!;
    local $/; my $old = <$ofh>; close $ofh;
    open(my $nfh, "<", $newf) or die $!;
    local $/; my $new = <$nfh>; close $nfh;
    my $idx = index($content, $old);
    if ($idx >= 0) {
      substr($content, $idx, length($old)) = $new;
      open(my $out, ">", $target) or die $!;
      print $out $content;
      close $out;
      print "REPLACED";
    } else {
      print "NOTFOUND";
    }
  ' "$TARGET" "$OLD_CONTENT_FILE" "$NEW_CONTENT_FILE"
}

patch_dir() {
  local GS_DIR="$1"

  echo "[fix-game-paths] Patching $GS_DIR ..."

  # 1. Client .tsx files: Replace path.join(...) with path.posix.join(...)
  #    Defense-in-depth: the installed path-browserify is POSIX-only already,
  #    so this isn't the load-bearing fix, but there's no reason to leave
  #    plain path.join(...) calls in client code that end up as file:// URIs.
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

  # 2. client/src/index.tsx: Remove React.StrictMode wrapper.
  #    `npm start` runs the client via Vite dev server (React dev mode), where
  #    StrictMode intentionally double-invokes effects (mount -> unmount ->
  #    mount) to surface side-effect bugs. The `App` component's useEffect
  #    (app.tsx) constructs a `new LeanMonaco()` singleton and calls its async
  #    `.start()`. On the double-invoke, a second LeanMonaco instance is
  #    created while the first's `.start()` is still in flight; lean4monaco
  #    disposes the first instance ("There can only be one active LeanMonaco
  #    instance at a time"), wasting a full Lean/Monaco boot and racing its
  #    teardown against the first instance's in-flight initialization.
  #    Removing StrictMode avoids the double effect invocation.
  local INDEX_TSX="$GS_DIR/client/src/index.tsx"
  if [ -f "$INDEX_TSX" ]; then
    if grep -q 'React.StrictMode' "$INDEX_TSX"; then
      perl -0777 -pi -e 's/<React\.StrictMode>\s*(<Router\s*\/>)\s*<\/React\.StrictMode>/$1/s' "$INDEX_TSX"
      if grep -q 'React.StrictMode' "$INDEX_TSX"; then
        echo "[fix-game-paths]   WARN client/src/index.tsx: StrictMode pattern not matched, left unpatched"
      else
        echo "[fix-game-paths]   OK client/src/index.tsx: removed React.StrictMode (avoids duplicate LeanMonaco instantiation)"
      fi
    else
      echo "[fix-game-paths]   SKIP client/src/index.tsx: StrictMode already removed"
    fi
  fi

  # 2b. client/src/app.tsx: pass a real, mounted wrapper element as
  #     `htmlElement` to LeanMonaco.start(), instead of leaving it undefined.
  #     This is the pattern lean4monaco's own README documents
  #     (`setOptions({...options, htmlElement: editorRef.current ?? undefined})`)
  #     but lean4game's editor-atoms.ts never actually wires it up (leaves it
  #     `undefined` unconditionally). Harmless either way for the "extent of
  #     certain monaco features such as the right-click context menu" that
  #     lean4monaco uses it for, but matches upstream's documented usage.
  local APP_TSX="$GS_DIR/client/src/app.tsx"
  if [ -f "$APP_TSX" ]; then
    if ! grep -q 'fix-game-paths' "$APP_TSX"; then
      if grep -q 'const appRef' "$APP_TSX"; then
        echo "[fix-game-paths]   SKIP client/src/app.tsx: appRef already present"
      else
        sed -i "s|const infoviewRef = useRef<HTMLDivElement>(null)|const infoviewRef = useRef<HTMLDivElement>(null)\n  const appRef = useRef<HTMLDivElement>(null) // [fix-game-paths] see htmlElement note below|" "$APP_TSX"
        sed -i "s|await _leanMonaco.start(leanMonacoOptions)|await _leanMonaco.start({ ...leanMonacoOptions, htmlElement: appRef.current ?? undefined }) // [fix-game-paths] pass a real wrapper element instead of leaving htmlElement undefined|" "$APP_TSX"
        sed -i 's|<div className="app">|<div className="app" ref={appRef}>|' "$APP_TSX"
        if grep -q 'appRef.current ?? undefined' "$APP_TSX" && grep -q 'ref={appRef}' "$APP_TSX"; then
          echo "[fix-game-paths]   OK client/src/app.tsx: wired appRef as LeanMonaco htmlElement"
        else
          echo "[fix-game-paths]   WARN client/src/app.tsx: pattern not fully matched, left partially patched -- check manually"
        fi
      fi
    else
      echo "[fix-game-paths]   SKIP client/src/app.tsx: already patched"
    fi
  fi

  # 2c. client/src/components/level.tsx: actually wire up the infoview host
  #     element. `app.tsx` calls `leanMonaco.setInfoviewElement(...)` once at
  #     top-level mount, but with a ref that's never attached to any rendered
  #     element (dead code) -- so `leanMonaco.infoviewEl` stays null and the
  #     infoview iframe factory's `.make()` throws ("Cannot read properties
  #     of undefined (reading 'append')") the first time a level tries to
  #     show a goal state, leaving the goal panel stuck spinning forever.
  #     level.tsx's own `PlayableLevel` component owns the ref that's
  #     actually rendered (`ExercisePanel`'s `infoviewRef`) but never called
  #     setInfoviewElement with it. This adds a small effect that does.
  local LEVEL_TSX="$GS_DIR/client/src/components/level.tsx"
  if [ -f "$LEVEL_TSX" ]; then
    if ! grep -q 'fix-game-paths' "$LEVEL_TSX"; then
      if grep -q '// Start the editor' "$LEVEL_TSX"; then
        perl -0777 -pi -e 's{(\n  // Start the editor\n  useEffect\(\(\) => \{\n    if \(leanMonaco\) \{)}{\n  \/\/ [fix-game-paths] wire up the infoview host element -- see scripts\/fix-game-paths.sh\n  useEffect(() => {\n    if (leanMonaco \&\& infoviewRef.current) {\n      leanMonaco.setInfoviewElement(infoviewRef.current)\n    }\n  }, [leanMonaco])\n$1}s' "$LEVEL_TSX"
        if grep -q 'wire up the infoview host element' "$LEVEL_TSX"; then
          echo "[fix-game-paths]   OK client/src/components/level.tsx: wired setInfoviewElement to the real infoviewRef"
        else
          echo "[fix-game-paths]   WARN client/src/components/level.tsx: pattern not matched, left unpatched"
        fi
      else
        echo "[fix-game-paths]   WARN client/src/components/level.tsx: '// Start the editor' anchor not found, left unpatched"
      fi
    else
      echo "[fix-game-paths]   SKIP client/src/components/level.tsx: infoview wiring already patched"
    fi

    # 2d. Same file: the infoview host div uses `display: 'none'`, which
    #     prevents its (unused, but still created by lean4monaco) iframe from
    #     ever getting a `contentWindow` in this environment --
    #     IFrameInfoWebviewFactory.make() unconditionally does
    #     `this.iframe.contentWindow.document.open()` right after appending
    #     the iframe, crashing with "Cannot read properties of null (reading
    #     'document')". Swap to an off-screen-but-still-laid-out hide instead.
    #     Checked independently of the marker above since both edits touch
    #     the same file but are otherwise unrelated.
    if grep -q "style={{display: 'none'}}></div>" "$LEVEL_TSX"; then
      sed -i "s|style={{display: 'none'}}></div>|style={{position: 'absolute', width: 0, height: 0, overflow: 'hidden', visibility: 'hidden', pointerEvents: 'none'}}></div>|" "$LEVEL_TSX"
      echo "[fix-game-paths]   OK client/src/components/level.tsx: infoview host no longer display:none (iframe can get a contentWindow)"
    elif grep -q "pointerEvents: 'none'" "$LEVEL_TSX"; then
      echo "[fix-game-paths]   SKIP client/src/components/level.tsx: infoview host display fix already patched"
    else
      echo "[fix-game-paths]   WARN client/src/components/level.tsx: infoview host display:none pattern not found, left unpatched"
    fi
  fi

  # 3. relay/src/serverProcess.ts: Add normalizePath helper
  #    Defense-in-depth for any backslash paths the relay (real Node.js,
  #    running with the host OS's actual process.platform) might embed into
  #    file:// URIs sent to the client.
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

  # 4. node_modules/vscode: hardcode the internal process shim's `platform`
  #    to 'linux' instead of reading the real (possibly win32) process.platform.
  #    THIS IS THE LOAD-BEARING FIX for the backslash-path/NoPermissions crash
  #    described at the top of this file. Only has an effect once `npm
  #    install` has populated node_modules, so this script must also be
  #    (re-)run after `npm install`, not only before it.
  local VSCODE_PROCESS_JS="$GS_DIR/node_modules/vscode/vscode/src/vs/base/common/process.js"
  if [ -f "$VSCODE_PROCESS_JS" ]; then
    if ! grep -q 'fix-game-paths' "$VSCODE_PROCESS_JS"; then
      if grep -q "get platform() { return process.platform; }" "$VSCODE_PROCESS_JS"; then
        sed -i "s|get platform() { return process.platform; },|get platform() { return 'linux'; }, /* [fix-game-paths] hardcoded: see scripts\/fix-game-paths.sh */|" "$VSCODE_PROCESS_JS"
        echo "[fix-game-paths]   OK node_modules/vscode .../process.js: hardcoded platform='linux'"
      else
        echo "[fix-game-paths]   WARN node_modules/vscode .../process.js: expected pattern not found, left unpatched"
      fi
    else
      echo "[fix-game-paths]   SKIP node_modules/vscode .../process.js: already patched"
    fi
  else
    echo "[fix-game-paths]   SKIP node_modules/vscode .../process.js: not installed yet (run again after npm install)"
  fi

  # 5. node_modules/vscode: force isWindows false in vs/base/common/platform.js.
  #    ANOTHER, INDEPENDENT LOAD-BEARING FIX. This module detects "Windows" via
  #    `navigator.userAgent` containing "Windows" (the branch taken in a real
  #    browser, since the polyfilled `process.versions.node` isn't a string) --
  #    completely separate from the process.js patch above. vs/base/common/
  #    uri.js reads `isWindows` from here directly and uses it to decide
  #    whether to join/format paths with `\` instead of `/`. Unlike the
  #    process.js fix (which only matters if the machine *building/serving*
  #    the client is Windows), this one triggers for ANY player whose browser
  #    happens to run on Windows -- regardless of where the game is hosted.
  local VSCODE_PLATFORM_JS="$GS_DIR/node_modules/vscode/vscode/src/vs/base/common/platform.js"
  if [ -f "$VSCODE_PLATFORM_JS" ]; then
    if ! grep -q 'fix-game-paths' "$VSCODE_PLATFORM_JS"; then
      if grep -q "console.error('Unable to resolve platform.');" "$VSCODE_PLATFORM_JS"; then
        perl -0777 -pi -e "s/(console\.error\('Unable to resolve platform\.'\);\n\})/\$1\n\/\/ [fix-game-paths] force isWindows false regardless of navigator.userAgent\/process detection above -- see scripts\/fix-game-paths.sh\n_isWindows = false;/" "$VSCODE_PLATFORM_JS"
        if grep -q '_isWindows = false;' "$VSCODE_PLATFORM_JS"; then
          echo "[fix-game-paths]   OK node_modules/vscode .../platform.js: forced isWindows=false"
        else
          echo "[fix-game-paths]   WARN node_modules/vscode .../platform.js: pattern replace failed, left unpatched"
        fi
      else
        echo "[fix-game-paths]   WARN node_modules/vscode .../platform.js: expected pattern not found, left unpatched"
      fi
    else
      echo "[fix-game-paths]   SKIP node_modules/vscode .../platform.js: already patched"
    fi
  else
    echo "[fix-game-paths]   SKIP node_modules/vscode .../platform.js: not installed yet (run again after npm install)"
  fi

  # 6. node_modules/vscode: make getClientArea degrade gracefully instead of
  #    throwing when it can't measure document.body (vs/base/browser/dom.js).
  #    This measurement (used before any editor container exists yet) can
  #    transiently see innerWidth/innerHeight and body/documentElement client
  #    dimensions all report 0. Throwing here rejects LeanMonaco.start()'s
  #    promise chain (unhandled -- no .catch() at the call site in app.tsx)
  #    and permanently aborts initialization, leaving the editor pane blank/
  #    non-interactive forever with no retry. vscode's layout system relayouts
  #    on later resize/container-attach events regardless, so a temporarily-
  #    wrong initial guess is recoverable where a hard crash is not.
  local VSCODE_DOM_JS="$GS_DIR/node_modules/vscode/vscode/src/vs/base/browser/dom.js"
  if [ -f "$VSCODE_DOM_JS" ]; then
    if ! grep -q 'fix-game-paths' "$VSCODE_DOM_JS"; then
      if grep -q "throw ( new Error('Unable to figure out browser width and height'));" "$VSCODE_DOM_JS"; then
        sed -i "s|throw ( new Error('Unable to figure out browser width and height'));|return ( new Dimension(window.screen?.width \|\| 1024, window.screen?.height \|\| 768)); /* [fix-game-paths] degrade gracefully instead of throwing: see scripts\/fix-game-paths.sh */|" "$VSCODE_DOM_JS"
        echo "[fix-game-paths]   OK node_modules/vscode .../dom.js: getClientArea no longer throws"
      else
        echo "[fix-game-paths]   WARN node_modules/vscode .../dom.js: expected pattern not found, left unpatched"
      fi
    else
      echo "[fix-game-paths]   SKIP node_modules/vscode .../dom.js: already patched"
    fi
  else
    echo "[fix-game-paths]   SKIP node_modules/vscode .../dom.js: not installed yet (run again after npm install)"
  fi

  # 7. node_modules/vscode-lean4 (standalone package, top-level in node_modules):
  #    retry-with-timeout around `$/lean/rpc/connect`. NOTE: this standalone
  #    copy of vscode-lean4 is NOT what lean4monaco actually imports at
  #    runtime -- see step 8 for the one that matters. Patched anyway,
  #    harmlessly, in case anything else in the dependency tree ever does
  #    import this copy directly.
  local INFOVIEW_TS="$GS_DIR/node_modules/vscode-lean4/vscode-lean4/src/infoview.ts"
  if [ -f "$INFOVIEW_TS" ]; then
    if ! grep -q 'fix-game-paths' "$INFOVIEW_TS"; then
      if grep -q "async function rpcConnect" "$INFOVIEW_TS"; then
        OLD_RPC_FILE="$(mktemp)"
        NEW_RPC_FILE="$(mktemp)"
        cat > "$OLD_RPC_FILE" <<'OLDRPCEOF'
async function rpcConnect(client: LeanClient, uri: ls.DocumentUri): Promise<string> {
    const connParams: RpcConnectParams = { uri };
    const result: RpcConnected = await client.sendRequest('$/lean/rpc/connect', connParams);
    return result.sessionId;
}
OLDRPCEOF
        cat > "$NEW_RPC_FILE" <<'NEWRPCEOF'
// [fix-game-paths] `sendRequest` has no built-in timeout: if the server never
// answers `$/lean/rpc/connect` (observed under system resource contention --
// the request can be silently dropped with no error, no response, ever),
// this hung forever with no retry, permanently stuck loading the goal state.
// Retry with a timeout instead of awaiting indefinitely.
const rpcConnectTimeoutMs = 10000
const rpcConnectMaxAttempts = 6

function delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms))
}

async function rpcConnect(client: LeanClient, uri: ls.DocumentUri): Promise<string> {
    const connParams: RpcConnectParams = { uri };
    let lastError: unknown
    for (let attempt = 1; attempt <= rpcConnectMaxAttempts; attempt++) {
        const timeout = new Promise<'timeout'>(resolve => setTimeout(() => resolve('timeout'), rpcConnectTimeoutMs))
        try {
            const outcome = await Promise.race([
                client.sendRequest('$/lean/rpc/connect', connParams).then((result: RpcConnected) => ({ result })),
                timeout.then(() => ({ timedOut: true as const })),
            ])
            if ('result' in outcome) return outcome.result.sessionId
            logger.log(`[InfoProvider] $/lean/rpc/connect timed out after ${rpcConnectTimeoutMs}ms (attempt ${attempt}/${rpcConnectMaxAttempts}), retrying`)
        } catch (e) {
            lastError = e
            logger.log(`[InfoProvider] $/lean/rpc/connect failed (attempt ${attempt}/${rpcConnectMaxAttempts}): ${e}`)
            await delay(1000)
        }
    }
    throw lastError ?? new Error(`$/lean/rpc/connect timed out after ${rpcConnectMaxAttempts} attempts`)
}
NEWRPCEOF
        REPLACE_RESULT=$(literal_replace_file "$INFOVIEW_TS" "$OLD_RPC_FILE" "$NEW_RPC_FILE")
        rm -f "$OLD_RPC_FILE" "$NEW_RPC_FILE"
        if [ "$REPLACE_RESULT" = "REPLACED" ]; then
          echo "[fix-game-paths]   OK node_modules/vscode-lean4 .../infoview.ts: rpcConnect now retries with a timeout"
        else
          echo "[fix-game-paths]   WARN node_modules/vscode-lean4 .../infoview.ts: expected rpcConnect body not found verbatim, left unpatched"
        fi
      else
        echo "[fix-game-paths]   WARN node_modules/vscode-lean4 .../infoview.ts: rpcConnect function not found, left unpatched"
      fi
    else
      echo "[fix-game-paths]   SKIP node_modules/vscode-lean4 .../infoview.ts: already patched"
    fi
  else
    echo "[fix-game-paths]   SKIP node_modules/vscode-lean4 .../infoview.ts: not installed yet (run again after npm install)"
  fi

  # 8. node_modules/lean4monaco/dist/vscode-lean4/...: the SAME retry-with-
  #    timeout fix as step 7, but on the copy that actually matters.
  #    lean4monaco does not import the standalone `vscode-lean4` package (step
  #    7) at all -- `leanmonaco.js` pulls in `InfoProvider` via a RELATIVE
  #    import from its OWN pre-compiled, vendored copy under
  #    `lean4monaco/dist/vscode-lean4/vscode-lean4/src/`. Confirmed by testing:
  #    patching only step 7's copy had zero effect on the running app; the
  #    goal panel kept hanging until this file was patched too.
  local INFOVIEW_JS="$GS_DIR/node_modules/lean4monaco/dist/vscode-lean4/vscode-lean4/src/infoview.js"
  if [ -f "$INFOVIEW_JS" ]; then
    if ! grep -q 'fix-game-paths' "$INFOVIEW_JS"; then
      if grep -q "async function rpcConnect" "$INFOVIEW_JS"; then
        OLD_RPC_JS_FILE="$(mktemp)"
        NEW_RPC_JS_FILE="$(mktemp)"
        cat > "$OLD_RPC_JS_FILE" <<'OLDRPCJSEOF'
const keepAlivePeriodMs = 10000;
async function rpcConnect(client, uri) {
    const connParams = { uri };
    const result = await client.sendRequest('$/lean/rpc/connect', connParams);
    return result.sessionId;
}
OLDRPCJSEOF
        cat > "$NEW_RPC_JS_FILE" <<'NEWRPCJSEOF'
const keepAlivePeriodMs = 10000;
// [fix-game-paths] `sendRequest` has no built-in timeout: if the server never
// answers `$/lean/rpc/connect` (observed under system resource contention --
// the request can be silently dropped with no error, no response, ever),
// this hung forever with no retry, permanently stuck loading the goal state.
// Retry with a timeout instead of awaiting indefinitely.
const rpcConnectTimeoutMs = 10000;
const rpcConnectMaxAttempts = 6;
function delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
async function rpcConnect(client, uri) {
    const connParams = { uri };
    let lastError;
    for (let attempt = 1; attempt <= rpcConnectMaxAttempts; attempt++) {
        const timeout = new Promise(resolve => setTimeout(() => resolve('timeout'), rpcConnectTimeoutMs));
        try {
            const outcome = await Promise.race([
                client.sendRequest('$/lean/rpc/connect', connParams).then((result) => ({ result })),
                timeout.then(() => ({ timedOut: true })),
            ]);
            if ('result' in outcome) return outcome.result.sessionId;
            logger.log(`[InfoProvider] $/lean/rpc/connect timed out after ${rpcConnectTimeoutMs}ms (attempt ${attempt}/${rpcConnectMaxAttempts}), retrying`);
        } catch (e) {
            lastError = e;
            logger.log(`[InfoProvider] $/lean/rpc/connect failed (attempt ${attempt}/${rpcConnectMaxAttempts}): ${e}`);
            await delay(1000);
        }
    }
    throw lastError ?? new Error(`$/lean/rpc/connect timed out after ${rpcConnectMaxAttempts} attempts`);
}
NEWRPCJSEOF
        REPLACE_RESULT=$(literal_replace_file "$INFOVIEW_JS" "$OLD_RPC_JS_FILE" "$NEW_RPC_JS_FILE")
        rm -f "$OLD_RPC_JS_FILE" "$NEW_RPC_JS_FILE"
        if [ "$REPLACE_RESULT" = "REPLACED" ]; then
          echo "[fix-game-paths]   OK node_modules/lean4monaco/.../infoview.js: rpcConnect now retries with a timeout (THE fix that matters)"
        else
          echo "[fix-game-paths]   WARN node_modules/lean4monaco/.../infoview.js: expected rpcConnect body not found verbatim, left unpatched"
        fi
      else
        echo "[fix-game-paths]   WARN node_modules/lean4monaco/.../infoview.js: rpcConnect function not found, left unpatched"
      fi
    else
      echo "[fix-game-paths]   SKIP node_modules/lean4monaco/.../infoview.js: already patched"
    fi
  else
    echo "[fix-game-paths]   SKIP node_modules/lean4monaco/.../infoview.js: not installed yet (run again after npm install)"
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
