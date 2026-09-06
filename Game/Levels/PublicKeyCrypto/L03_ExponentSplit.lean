import Game.Metadata
import Mathlib.Tactic.Common
import Mathlib.Tactic.Ring

World "PublicKeyCrypto"
Level 3

Title "Splitting Off the Euler Part"

Introduction
"
## Why the Key Relation Has a '+1' in It

RSA's key relation `e * d ≡ 1 (mod φ(n))` means, unpacked, that
`e * d = 1 + k * φ(n)` for some whole number `k`. That '+1' is exactly what
survives at the end; the `k * φ(n)` part is exactly what Euler's Theorem is
about to make vanish.

### Your Task

Prove the purely algebraic fact this decomposition relies on:
`m ^ (1 + k * t) = m * (m ^ t) ^ k`.

### Strategy

This is ordinary exponent arithmetic in a commutative semiring — no
congruences involved yet.
"

Statement (m k t : ℕ) : m ^ (1 + k * t) = m * (m ^ t) ^ k := by
  Hint "This is a pure exponent-arithmetic identity. Type: ring"
  ring

Conclusion
"
`m ^ (e*d)` splits into a lone `m` times `k` copies of `m ^ φ(n)` — and
Euler's Theorem says each of those copies is congruent to `1`. That's the
whole mechanism the capstone assembles.

**APOS stage:** Object — an algebraic identity, isolated and proved once,
ready to be reused as a single step inside a larger proof.
"
