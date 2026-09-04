import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.Tactic.Common

World "MinRank"
Level 1

Title "Linear Combinations of Matrices"

Introduction
"
## Linear Combinations

In the MinRank problem, we work with linear combinations of matrices:

    M = lambda_1 * M_1 + lambda_2 * M_2 + ... + lambda_k * M_k

In Lean, the sum of two matrices is component-wise, and scalar multiplication
scales every entry. These are just the standard module operations on `Matrix`.

### Your Task

Prove that lambda * A + 0 * A = lambda * A for any matrix `A`
and scalar `lambda`.

### Strategy

1. `rw` to simplify `0 * A` to `0` using `zero_smul`.
2. `rw` to simplify `lambda * A + 0` to `lambda * A` using `add_zero`.
3. Close with `rfl`.
"

Statement {F : Type} [Field F] {m n : ℕ}
    (c : F) (A : Matrix (Fin m) (Fin n) F) :
    c • A + 0 • A = c • A := by
  Hint "Simplify 0 • A to 0 using `zero_smul`. Type: rw [zero_smul]"
  rw [zero_smul]
  Hint "Simplify c • A + 0 to c • A using `add_zero`. Type: rw [add_zero]"
  rw [add_zero]

Conclusion
"
Linear combinations of matrices are the basic objects in the MinRank problem.
The goal is to find coefficients lambda_i making a particular linear combination
have low rank.

**APOS stage:** Action — two explicit, mechanical simplification steps.
"

NewTactic rw rfl
