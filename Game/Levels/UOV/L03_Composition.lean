import Game.Metadata
import Mathlib.Algebra.Module.LinearMap.Defs
import Mathlib.Tactic.Common

World "UOV"
Level 3

Title "Composing Linear and Quadratic Maps"

Introduction
"
## Composition in UOV

The UOV public key is P = F composed with S, where:
- S : F^n -> F^n is a secret linear map.
- F : F^n -> F^o is the (quadratic) central map.

The correctness of signing requires that if sigma = S^{-1}(o, v) and
F(o, v) = y, then P(sigma) = y.

This follows from: P(sigma) = F(S(sigma)) = F(o, v) = y.

### Your Task

Prove a simplified version: if `f` and `g` are linear maps and `h` is a third linear map,
then `(h.comp g).comp f = h.comp (g.comp f)` — composition is associative.

### Strategy

Use `LinearMap.comp_assoc`.
"

Statement {R : Type} [CommRing R] {M N P Q : Type}
    [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]
    [AddCommGroup P] [Module R P]
    [AddCommGroup Q] [Module R Q]
    (f : M →ₗ[R] N) (g : N →ₗ[R] P) (h : P →ₗ[R] Q) :
    (h.comp g).comp f = h.comp (g.comp f) := by
  Hint "Composition of linear maps is associative. Use `LinearMap.comp_assoc`."
  rw [LinearMap.comp_assoc]

Conclusion
"
Associativity of composition means the order of grouping doesn't matter.
In UOV, the public key P = F composed with S involves composing
maps, and associativity guarantees we can regroup compositions as needed.
"

NewTactic exact
