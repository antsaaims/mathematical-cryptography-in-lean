import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MinRank"
Level 7

Title "Capstone: The MinRank Identity"

Introduction
"
## Capstone: MinRank Key Identity

The MinRank problem seeks lambda_1, lambda_2 such that
det(lambda_1 * A + lambda_2 * B) = 0 (for the rank-deficient case with 2 matrices).

A key algebraic identity used in MinRank solvers is the **multilinearity** of the
determinant in the matrix argument. Specifically, for a scalar lambda:

    det(lambda * A) = lambda^n * det(A)

When det(A) = 0 (i.e., A is already singular), then det(lambda * A) = 0
for any lambda. This is why rank-deficient matrices are the targets in MinRank.

### Your Task

Prove: if det(A) = 0, then det(lambda * A) = 0.

### Strategy

1. Use `Matrix.det_smul` to rewrite `(lambda * A).det` as `lambda^n * A.det`.
2. Rewrite `A.det` to `0` using the hypothesis `h`.
3. Simplify `lambda^n * 0` to `0` using `mul_zero`.
"

Statement {F : Type} [Field F] {n : ℕ}
    (c : F) (A : Matrix (Fin n) (Fin n) F)
    (h : A.det = 0) :
    (c • A).det = 0 := by
  Hint "Step 1: Rewrite det(c • A) = c^Fintype.card (Fin n) * det(A). Type: rw [Matrix.det_smul]"
  rw [Matrix.det_smul]
  Hint "Step 2: Substitute det(A) = 0 using hypothesis h. Type: rw [h]"
  rw [h]
  Hint "Step 3: Simplify c^n * 0 to 0. Type: rw [mul_zero]"
  rw [mul_zero]

Conclusion
"
**Congratulations!** You have completed the MinRank World!

You just proved the **MinRank key identity**: if a matrix A is singular
(det(A) = 0), then any scalar multiple lambda * A is also singular.

This is the algebraic foundation of MinRank attacks:
- The attacker searches for lambda_i making Sum lambda_i M_i singular.
- If the target combination has a singular component, the scalar multiples
  preserve singularity.
- The determinant becomes a polynomial in the lambda_i, and finding its roots
  solves the MinRank instance.

## What You Have Learned

Across all four worlds, you have:
1. Mastered the core Lean tactics: `rw`, `exact`, `apply`, `simp`, `ring`.
2. Worked with matrices, determinants, transposes, and submatrices in Mathlib.
3. Proved the correctness of the UOV signature scheme.
4. Formalized key identities underlying the MinRank and Support-Minor models.

You are now equipped to read and write research-grade Lean 4 / Mathlib proofs in
algebraic cryptography. Well done!
"

NewTactic rw exact
NewDefinition Matrix.det
