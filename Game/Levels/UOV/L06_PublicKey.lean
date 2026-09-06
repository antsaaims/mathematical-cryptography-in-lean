import Game.Metadata
import Mathlib.LinearAlgebra.QuadraticForm.Basic
import Mathlib.Tactic.Common

World "UOV"
Level 6

Title "The Public Key as a Composition"

Introduction
"
## Public Key Structure, Now Properly Quadratic

In UOV, the public key is defined as `P = F composed with S`, where `S` is
an invertible **linear** map and `F` is the **quadratic** central map from
Level 1 — this time, with `F` given its correct type, `QuadraticMap R M N`,
rather than being (incorrectly) treated as linear.

For verification, we need: `P(sigma) = F(S(sigma))`. Composing a quadratic
map with a linear map on the input side is exactly `QuadraticMap.comp`.

### Your Task

Prove that if `P = F.comp S` (the public key is the composition), then
`P x = F (S x)` for any input `x`.

### Strategy

Apply the definition of composition, now for a quadratic map composed with
a linear map — `QuadraticMap.comp_apply`, the quadratic analogue of
`LinearMap.comp_apply`.
"

Statement {R M N : Type} [CommRing R]
    [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]
    (S : M →ₗ[R] M) (F : QuadraticMap R M N)
    (x : M) :
    (F.comp S) x = F (S x) := by
  Hint "This is the quadratic-map analogue of `LinearMap.comp_apply`. Type: exact QuadraticMap.comp_apply F S x"
  exact QuadraticMap.comp_apply F S x

Conclusion
"
This is the fundamental identity underlying UOV verification:
`P(sigma) = F(S(sigma))` — and unlike Level 4's version of this composition
fact, `F` is genuinely quadratic here, exactly matching Level 3's
description of UOV's central map.

The public key `P` is applied to the signature `sigma`, which equals
applying the secret linear map `S` first, then the central quadratic map `F`.

**APOS stage:** Object — the public key `P` itself is now treated as one
first-class object (a composition), not merely a sequence of steps to perform.
"

NewTheorem QuadraticMap.comp_apply
