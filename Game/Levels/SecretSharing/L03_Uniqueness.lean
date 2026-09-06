import Game.Metadata
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Tactic.Common

World "SecretSharing"
Level 3

Title "The Shares Determine the Secret"

Introduction
"
## No Two Different Answers

Level 1 showed the interpolating polynomial fits its input data. Here is
the fact that makes secret sharing *secure* rather than just *convenient*:
if two value-functions `r` and `r'` happen to interpolate to the exact same
polynomial, they must have agreed at every single input point all along.
There's no way for two genuinely different sets of shares to reconstruct
the same polynomial by coincidence.

### Your Task

Given that `r` and `r'` interpolate (over the same `s`, `v`) to the same
polynomial, prove they agree at every point of `s`.

### Strategy

Mathlib already packages this as an if-and-only-if; you only need one
direction of it.
"

Statement {F : Type} [Field F] {ι : Type} [DecidableEq ι]
    (s : Finset ι) (v r r' : ι → F) (hvs : Set.InjOn v s)
    (heq : Lagrange.interpolate s v r = Lagrange.interpolate s v r') :
    ∀ i ∈ s, r i = r' i := by
  Hint "Mathlib states this as an iff — take the forward direction. Type: exact (Lagrange.interpolate_eq_iff_values_eq_on r r' hvs).mp heq"
  exact (Lagrange.interpolate_eq_iff_values_eq_on r r' hvs).mp heq

Conclusion
"
The map from 'values at the nodes' to 'the interpolating polynomial' is
injective. This is the same spine idea you formalized for the one-time pad
(a unique key for every message/ciphertext pair) and for the Caesar/
substitution ciphers (an invertible map) — reappearing here as: a
polynomial's values at enough points pin it down completely, with no room
for ambiguity.

**APOS stage:** Object — treating 'the interpolating polynomial' as a
single well-defined object determined by, and determining, its input data.
"
