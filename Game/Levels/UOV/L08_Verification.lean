import Game.Metadata
import Mathlib.LinearAlgebra.QuadraticForm.Basic
import Mathlib.Algebra.Module.Equiv.Defs
import Mathlib.Tactic.Common

World "UOV"
Level 8

Title "UOV Verification Correctness"

Introduction
"
## Full UOV Correctness

We now combine every piece to prove the **UOV correctness theorem**:

**If** sigma = S^{-1}(w) and F(w) = y,
**then** P(sigma) = y.

Proof:
1. P(sigma) = (F composed with S)(sigma) = F(S(sigma))
   (definition of composition, now for genuinely quadratic F).
2. S(sigma) = S(S^{-1}(w)) = w (inverse property).
3. F(w) = y (given).
4. Therefore P(sigma) = y.

### Your Task

Given:
- `e : M ≃ₗ[R] M` (the secret linear map S, as a linear equivalence)
- `F : QuadraticMap R M N` (the central quadratic map)
- `w : M` (the intermediate value (o, v))
- `hF : F w = y` (the central map gives the target)
- `y : N` (the target hash value)

Prove: `(F.comp e.toLinearMap) (e.symm w) = y`

This is: P(sigma) = y where sigma = S^{-1}(w) and P = F composed with S.

### Strategy

1. Rewrite `(F.comp e.toLinearMap) (e.symm w)` to `F (e.toLinearMap (e.symm w))`
   using `QuadraticMap.comp_apply`.
2. Rewrite `e.toLinearMap (e.symm w)` to `w` using `e.apply_symm_apply`.
3. The goal becomes `F w = y`, which is exactly `hF`. Use `exact hF`.
"

Statement {R M N : Type} [CommRing R]
    [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]
    (e : M ≃ₗ[R] M) (F : QuadraticMap R M N)
    (w : M) (y : N) (hF : F w = y) :
    (F.comp e.toLinearMap) (e.symm w) = y := by
  Hint "Step 1: Unfold composition, now for a quadratic map. Type: show F (e (e.symm w)) = y"
  show F (e (e.symm w)) = y
  Hint "Step 2: Simplify e (e.symm w) to w. Type: rw [e.apply_symm_apply]"
  rw [e.apply_symm_apply]
  Hint "Step 3: The goal is now F w = y, which is hF. Type: exact hF"
  exact hF

Conclusion
"
You have proved the UOV correctness theorem: if the signer produces
sigma = S^{-1}(w) where F(w) = y, then the verifier always accepts because
P(sigma) = y — and this time, F genuinely has the quadratic type Level 1
and Level 3 said it should.

The full UOV scheme adds hashing (to generate y from a message m) and
random vinegar selection, but the algebraic core is exactly what you just
proved.

Three levels remain: QR-UOV's quotient ring, an invertibility fact
Threshold UOV depends on, and a capstone connecting this whole world back
to Secret Sharing World.

**APOS stage:** Object — synthesizing linear maps, quadratic maps,
invertibility, and composition into a coherent cryptographic system, three
levels before this world's true Schema-stage capstone.
"

