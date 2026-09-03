import Game.Metadata
import Mathlib.Algebra.Module.LinearMap.Defs
import Mathlib.Tactic.Common

World "UOV"
Level 1

Title "Linear Maps and Their Composition"

Introduction
"
## Linear Maps in Lean

In UOV, the secret transformation S is an invertible linear map on F^n.
In Mathlib, a linear map from module `M` to module `N` is `M →ₗ[R] N`
(read: linear map from M to N).

The composition of linear maps `f` and `g` is written `g.comp f` (first apply `f`,
then `g`).

### Cryptographic Context

In UOV, the public key is P = F composed with S. Here, S is a
linear map and F is a quadratic map. The composition F composed with S
means: first apply S to the input, then apply F.

### Your Task

Prove that applying the composition `g.comp f` to a vector `x` gives `g (f x)`.

### Strategy

Use the lemma `LinearMap.comp_apply`, which states `(g.comp f) x = g (f x)`.
"

Statement {R : Type} [CommRing R] {M N P : Type}
    [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]
    [AddCommGroup P] [Module R P]
    (f : M →ₗ[R] N) (g : N →ₗ[R] P) (x : M) :
    (g.comp f) x = g (f x) := by
  Hint "Use `LinearMap.comp_apply`. Type: exact LinearMap.comp_apply g f x"
  exact LinearMap.comp_apply g f x

Conclusion
"
Linear map composition is the algebraic backbone of UOV. The public key transformation
is literally a composition of linear and quadratic maps. You now know how Lean
represents this fundamental operation.
"

NewTactic exact
NewDefinition LinearMap
