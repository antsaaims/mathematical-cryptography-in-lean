import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.Module.LinearMap.Defs
import Mathlib.Tactic.Common

World "UOV"
Level 5

Title "The Public Key as a Composition"

Introduction
"
## Public Key Structure

In UOV, the public key is defined as:

    P = F composed with S

where S is an invertible linear map and F is the central quadratic map.

For verification, we need: P(sigma) = F(S(sigma)).

This is just the definition of function composition applied to a specific input.

### Your Task

Prove that if `P = F.comp S` (the public key is the composition), then
`P x = F (S x)` for any input `x`.

### Strategy

Apply the definition of composition using `LinearMap.comp_apply`.
"

Statement {R : Type} [CommRing R] {M N : Type}
    [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]
    (S : M →ₗ[R] M) (F : M →ₗ[R] N)
    (x : M) :
    (F.comp S) x = F (S x) := by
  Hint "Apply the definition of composition. Type: exact LinearMap.comp_apply F S x"
  exact LinearMap.comp_apply F S x

Conclusion
"
This is the fundamental identity underlying UOV verification:
P(sigma) = F(S(sigma)).

The public key P is applied to the signature sigma, which equals
applying the secret linear map S first, then the central map F.

**APOS stage:** Object — the public key `P` itself is now treated as one
first-class object (a composition), not merely a sequence of steps to perform.
"

NewTactic exact
