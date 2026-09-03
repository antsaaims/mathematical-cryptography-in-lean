import Game.Metadata
import Mathlib.Algebra.Module.LinearMap.Defs
import Mathlib.Algebra.Module.Equiv.Defs
import Mathlib.Tactic.Common

World "UOV"
Level 7

Title "Capstone: UOV Correctness"

Introduction
"
## Capstone: Full UOV Correctness

We now combine all the pieces to prove the **UOV correctness theorem**:

**If** sigma = S^{-1}(w) and F(w) = y,
**then** P(sigma) = y.

Proof:
1. P(sigma) = (F composed with S)(sigma) = F(S(sigma))
   (definition of composition).
2. S(sigma) = S(S^{-1}(w)) = w (inverse property).
3. F(w) = y (given).
4. Therefore P(sigma) = y.

### Your Task

Given:
- `e : M ≃ₗ[R] M` (the secret linear map S, as a linear equivalence)
- `F : M →ₗ[R] N` (the central map F)
- `w : M` (the intermediate value (o, v))
- `hF : F w = y` (the central map gives the target)
- `y : N` (the target hash value)

Prove: `(F.comp e.toLinearMap) (e.symm w) = y`

This is: P(sigma) = y where sigma = S^{-1}(w) and P = F composed with S.

### Strategy

1. Rewrite `(F.comp e.toLinearMap) (e.symm w)` to `F (e.toLinearMap (e.symm w))`
   using `LinearMap.comp_apply`.
2. Rewrite `e.toLinearMap (e.symm w)` to `w` using `e.apply_symm_apply`.
3. The goal becomes `F w = y`, which is exactly `hF`. Use `exact hF`.
"

Statement {R : Type} [CommRing R] {M N : Type}
    [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N]
    (e : M ≃ₗ[R] M) (F : M →ₗ[R] N)
    (w : M) (y : N) (hF : F w = y) :
    (F.comp e.toLinearMap) (e.symm w) = y := by
  Hint "Step 1: Unfold composition. Type: show F (e (e.symm w)) = y"
  show F (e (e.symm w)) = y
  Hint "Step 2: Simplify e (e.symm w) to w. Type: rw [e.apply_symm_apply]"
  rw [e.apply_symm_apply]
  Hint "Step 3: The goal is now F w = y, which is hF. Type: exact hF"
  exact hF

Conclusion
"
**Congratulations!** You have proved the UOV correctness theorem!

In 3 tactic lines, you showed that the UOV signature scheme is correct:
if the signer produces sigma = S^{-1}(w) where F(w) = y,
then the verifier always accepts because P(sigma) = y.

This is the **Schema** stage of APOS: you synthesized linear maps, quadratic forms,
invertibility, and composition into a coherent cryptographic system.

The full UOV scheme adds hashing (to generate y from a message m) and random
vinegar selection, but the algebraic core is exactly what you just proved.

Next: **MinRank World**, where you will formalize the MinRank problem and its
connection to cryptographic attacks.
"

NewTactic rw exact
