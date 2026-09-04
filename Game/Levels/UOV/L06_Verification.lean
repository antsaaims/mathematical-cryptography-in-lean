import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.Module.LinearMap.Defs
import Mathlib.Algebra.Module.Equiv.Defs
import Mathlib.Tactic.Common

World "UOV"
Level 6

Title "The Verification Identity"

Introduction
"
## UOV Verification

UOV verification checks: P(sigma) = y where y = H(m).

By the structure of the public key (P = F composed with S), this is:

    F(S(sigma)) = y

During signing, we chose sigma = S^{-1}(o, v) where F(o, v) = y.
So S(sigma) = S(S^{-1}(o, v)) = (o, v), and thus:

    P(sigma) = F(S(sigma)) = F(o, v) = y

### Your Task

Prove that if e is a linear equivalence with e composed with e^{-1} = id,
and we set sigma = e^{-1}(w), then e(sigma) = w.

In other words: if sigma = S^{-1}(w), then S(sigma) = w.

### Strategy

Use the property that `e (e.symm w) = w`, which is `e.apply_symm_apply`.
"

Statement {R : Type} [CommRing R] {M : Type}
    [AddCommGroup M] [Module R M]
    (e : M ≃ₗ[R] M) (w : M) :
    e.toLinearMap (e.symm w) = w := by
  Hint "Use `e.apply_symm_apply` which states e (e.symm w) = w."
  Hint "Try: exact e.apply_symm_apply w"
  exact e.apply_symm_apply w

Conclusion
"
This proves the key step in UOV verification: applying S to sigma = S^{-1}(w)
recovers w. Combined with F(w) = y, this gives:

    P(sigma) = F(S(sigma)) = F(w) = y

which is exactly the verification condition!

**APOS stage:** Object — reasoning about the linear equivalence `e` and its
inverse as objects with algebraic properties (`e.apply_symm_apply`), not
individual computations.
"

NewTactic exact
