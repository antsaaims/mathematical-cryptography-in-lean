import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 6

Title "Capstone: The Rank-Determinant Connection"

Introduction
"
## Capstone: Putting It All Together

The **rank** of a matrix is the size of its largest invertible (non-zero determinant)
square submatrix. A matrix has rank < r if and only if all r×r minors
vanish (have determinant zero).

### Cryptographic Significance

The **MinRank problem** asks: given matrices M_1, ..., M_k and a target rank r,
find scalars lambda_1, ..., lambda_k (not all zero) such that:

    rank(Sum lambda_i M_i) <= r

This is the computational heart of attacks on multivariate schemes.

### Your Task

Prove a simpler related fact: the determinant of a product equals the product of
determinants, combined with the fact that the identity matrix has determinant 1.

Specifically, given an invertible matrix `A` and the identity matrix, prove:
`(A * 1).det = A.det * 1`

### Strategy

1. Use `rw` to simplify `A * 1` to `A` using `Matrix.mul_one`.
2. Use `rw` to simplify `A.det * 1` to `A.det` using `mul_one`.
3. The goal becomes `A.det = A.det`, which closes with `rfl`.
"

Statement {F : Type} [Field F] {n : ℕ}
    (A : Matrix (Fin n) (Fin n) F) :
    (A * 1).det = A.det * 1 := by
  Hint "Simplify A * 1 to A using Matrix.mul_one. Type: rw [Matrix.mul_one]"
  rw [Matrix.mul_one]
  Hint "Simplify A.det * 1 to A.det using mul_one. Type: rw [mul_one]"
  rw [mul_one]

Conclusion
"
Congratulations! You have completed the Matrix Algebra World.

You now understand matrices, determinants, transposes, and submatrices — the
fundamental objects of algebraic cryptography. The connection between rank and
determinants of submatrices (minors) is the mathematical foundation of the
MinRank and Support-Minor attacks.

Next: **UOV World**, where you will prove the correctness of the Unbalanced Oil
and Vinegar signature scheme.

**APOS stage:** Schema — combining the determinant (Action/Process) and submatrix
(Object) material from this whole world into one synthesized fact.
"

NewTactic rw rfl
