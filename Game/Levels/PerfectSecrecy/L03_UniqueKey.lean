import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "PerfectSecrecy"
Level 3

Title "Only One Key Could Have Done That"

Introduction
"
## The Heart of Perfect Secrecy

Here is the property that makes the one-time pad special. Fix a single
plaintext bit `m` and a single ciphertext bit `c` that an eavesdropper
observes. *Some* key turns `m` into `c` — but could two *different* keys
both have done it?

If they could, an eavesdropper who only sees `c` would have no way to rule
out any candidate message: for every possible `m`, there's a key that
explains the observed `c`, and (as you're about to show) it's never
ambiguous which key that was. Combine that with a key chosen *uniformly at
random* (an assumption about how the key was picked, not something this
level proves) and you get exactly Shannon's notion of *perfect secrecy*:
the ciphertext alone carries no information at all about which key — and
hence which message — produced it.

### Your Task

Given a plaintext bit `m` and two keys `k1`, `k2` that both encrypt `m` to
the same ciphertext `c`, prove the two keys must actually be the same key.

### Strategy

Substitute one hypothesis into the other, then cancel the shared `m`.
"

Statement (m c k1 k2 : ZMod 2) (h1 : m + k1 = c) (h2 : m + k2 = c) : k1 = k2 := by
  Hint "Replace `c` in `h1` using `h2`, so both sides mention only `m`, `k1`, `k2`. Type: rw [← h2] at h1"
  rw [← h2] at h1
  Hint "Both sides now start with `m + …` — cancel it. Type: exact add_left_cancel h1"
  exact add_left_cancel h1

Conclusion
"
Given the ciphertext and the plaintext, the key is completely determined —
there is exactly one key that could have produced what you saw. Combined
with Level 2 (every key is reachable, since encryption is its own inverse),
this means every (message, ciphertext) pair corresponds to *exactly* one
key — the exact combinatorial statement of perfect secrecy, one bit at a
time. It holds bit-by-bit across an entire n-bit message the same way
Level 2's roundtrip did.

**APOS stage:** Object — 'the key' is now something you reason about as a
uniquely-determined value, not just something you compute with.
"

NewTheorem add_left_cancel
