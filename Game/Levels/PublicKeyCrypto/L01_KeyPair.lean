import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "PublicKeyCrypto"
Level 1

Title "A Real (Tiny) RSA Key Pair"

Introduction
"
## Public and Private Exponents

RSA picks two distinct primes `p`, `q`, sets `n = p * q`, and chooses a
public encryption exponent `e` and private decryption exponent `d`
satisfying `e * d ≡ 1 (mod φ(n))`. Take `p = 3`, `q = 5`, so `n = 15` and
`φ(n) = φ(3) * φ(5) = 2 * 4 = 8`.

### Your Task

Check that `e = 3`, `d = 3` really is a valid key pair for this `n`:
`e * d ≡ 1 (mod φ(n))`, i.e. `3 * 3 ≡ 1 (mod 8)`.

### Strategy

Everything here is a small, fixed number — Lean can just check it.
"

Statement : (3 : ZMod 8) * 3 = 1 := by
  Hint "Small, fixed numbers — Lean can compute this directly. Type: decide"
  decide

Conclusion
"
`3 * 3 = 9 = 8 + 1`, so `e = d = 3` is a genuine (if tiny and insecure) RSA
key pair for `n = 15`. Real RSA uses `n` hundreds of digits long — but the
algebraic relationship your key pair must satisfy is exactly this one,
just at a scale no one can search by hand.

**APOS stage:** Action — a single concrete verification.
"
