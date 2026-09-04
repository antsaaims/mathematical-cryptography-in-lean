import Game.Metadata
import Mathlib.Algebra.Module.LinearMap.Defs
import Mathlib.Algebra.Module.Equiv.Defs
import Mathlib.Tactic.Common

World "UOV"
Level 4

Title "Invertible Linear Maps"

Introduction
"
## Invertible Maps and UOV Signing

In UOV, the secret map S must be **invertible** — otherwise, we cannot compute
sigma = S^{-1}(o, v) during signing.

In Mathlib, a linear equivalence `M ≃ₗ[R] N` is a linear map with a two-sided
inverse. If `e : M ≃ₗ[R] N`, then `e.symm : N ≃ₗ[R] M` is the inverse,
and `e.toLinearMap` is the forward map.

Key property: `e.symm.toLinearMap` composed with `e.toLinearMap` equals `LinearMap.id`
(applying S then S^{-1} gives the identity).

### Your Task

Prove that composing a linear equivalence with its inverse (in the correct order)
gives the identity.

### Strategy

Use `e.symm_comp`, which states `e.symm.toLinearMap ∘ₛₗ e.toLinearMap = LinearMap.id`.
"

Statement {R : Type} [CommRing R] {M N : Type}
    [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]
    (e : M ≃ₗ[R] N) :
    e.symm.toLinearMap.comp e.toLinearMap = LinearMap.id := by
  Hint "Use `e.symm_comp` which states e.symm.toLinearMap ∘ₛₗ e.toLinearMap = LinearMap.id."
  Hint "Try: exact e.symm_comp"
  exact e.symm_comp

Conclusion
"
Invertibility is the key algebraic property that makes UOV signing possible.
S^{-1} exists precisely because S is a linear equivalence.

In the signing procedure, we compute sigma = S^{-1}(o, v). The fact that
S composed with S^{-1} = id guarantees that S(sigma) = (o, v), which is
what we need for correctness.

**APOS stage:** Process — invertibility is a general property of a *class* of maps
(linear equivalences), not a one-off fact about a single map.
"
NewDefinition LinearEquiv
