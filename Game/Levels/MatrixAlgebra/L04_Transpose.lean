import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Defs
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 4

Title "Transpose of a Product"

Introduction
"
## Matrix Transpose

The **transpose** of a matrix `A`, written `Aᵀ` in Mathlib (or `Matrix.transpose A`),
flips rows and columns: (A^T)_ij = A_ji.

A key identity is:

    (A * B)^T = B^T * A^T

Note the **reversal** of order — this is crucial when manipulating matrix expressions.

### Your Task

Prove that `(A * B)ᵀ = Bᵀ * Aᵀ`.

### Strategy

Use the lemma `Matrix.transpose_mul`.

### Cryptographic Context

In UOV, the public map is often written as P(x) = x^T * P * x
where P is a matrix of public-key coefficients. Transpose identities appear when
manipulating such quadratic forms.
"

Statement {F : Type} [Field F] {m n k : ℕ}
    (A : Matrix (Fin m) (Fin n) F) (B : Matrix (Fin n) (Fin k) F) :
    Matrix.transpose (A * B) = Matrix.transpose B * Matrix.transpose A := by
  Hint "Use `Matrix.transpose_mul`. Type: exact Matrix.transpose_mul A B"
  exact Matrix.transpose_mul A B

Conclusion
"
The transpose reverses multiplication order. This reversal is a common source of
errors in hand calculations, but Lean keeps us honest.

In quadratic-form-based cryptography (like UOV), transpose identities are pervasive.

**APOS stage:** Process — another structural law about how an operation
(transpose) interacts with another (multiplication).
"

NewTactic exact
NewDefinition Matrix.transpose
