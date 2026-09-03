import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Defs
import Mathlib.Tactic.Common

World "MinRank"
Level 6

Title "Linear Combinations and Transpose"

Introduction
"
## Manipulating Linear Combinations

In MinRank attacks, we frequently manipulate expressions like
M = Sum lambda_i M_i and need to relate properties of M to properties of
M^T (its transpose).

Key fact: rank(M) = rank(M^T), and
(Sum lambda_i M_i)^T = Sum lambda_i M_i^T.

### Your Task

Prove that the transpose of `A + B` equals `Aᵀ + Bᵀ`.

### Strategy

Use `Matrix.transpose_add`.
"

Statement {F : Type} [Field F] {m n : ℕ}
    (A B : Matrix (Fin m) (Fin n) F) :
    Matrix.transpose (A + B) = Matrix.transpose A + Matrix.transpose B := by
  Hint "The transpose of a sum is the sum of transposes."
  Hint "Type: exact Matrix.transpose_add A B"
  exact Matrix.transpose_add A B

Conclusion
"
The transpose distributes over addition. This means that linear combinations of
transposes equal transposes of linear combinations — a key tool when manipulating
matrix expressions in MinRank attacks.

Combined with `Matrix.transpose_mul` (from the Matrix Algebra world), you can now
manipulate arbitrary matrix expressions involving sums, products, and transposes.
"

NewTactic exact
