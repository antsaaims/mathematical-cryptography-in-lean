import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MinRank"
Level 2

Title "Zero Scalar Gives Zero Determinant"

Introduction
"
## Singular Combinations

In MinRank, we seek lambda_i such that Sum lambda_i M_i has low rank.
The extreme case is rank 0, meaning the combination is the zero matrix.

If lambda = 0, then lambda * A = 0 (zero matrix), and
det(lambda * A) = det(0) = 0.

### Your Task

Prove that if lambda = 0, then det(lambda * A) = 0.

### Strategy

1. Rewrite the hypothesis h : lambda = 0 into the goal.
2. Simplify `0 * A` to `0`.
3. Use `Matrix.det_zero` to show det(0) = 0.
"

Statement {F : Type} [Field F] {n : ℕ} [NeZero n]
    (c : F) (A : Matrix (Fin n) (Fin n) F)
    (h : c = 0) :
    (c • A).det = 0 := by
  Hint "Substitute c with 0 using `h`. Type: rw [h]"
  rw [h]
  Hint "Simplify 0 • A to 0. Type: rw [zero_smul]"
  rw [zero_smul]
  Hint "Use `simp` to show det(0) = 0. Type: simp [Matrix.det_zero]"
  simp [Matrix.det_zero]

Conclusion
"
When all coefficients are zero, the linear combination is the zero matrix — which
has determinant zero and rank zero. This is the trivial (degenerate) solution to
MinRank. The interesting challenge is finding non-trivial lambda_i that produce
low rank.
"

NewTactic rw exact
NewDefinition Matrix.det
