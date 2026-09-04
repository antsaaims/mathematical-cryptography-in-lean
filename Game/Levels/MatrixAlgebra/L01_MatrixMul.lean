import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 1

Title "Matrix Multiplication"

Introduction
"
## Matrix Multiplication in Mathlib

In Mathlib, a matrix with `m` rows and `n` columns over a field `F` is written as
`Matrix (Fin m) (Fin n) F`.

Matrix multiplication is defined as:

    (A * B)_ij = Sum_k A_ik * B_kj

The identity matrix `1` satisfies `A * 1 = A` and `1 * A = A`.

### Your Task

Prove that multiplying any matrix `A` by the identity matrix (of compatible size)
on the right gives back `A`.

### Strategy

The lemma `Matrix.mul_one` states exactly this. Use `exact` to close the goal.

### Cryptographic Context

In UOV, the public key transformation is a matrix-vector product. Verifying that
multiplication by the identity leaves a matrix unchanged is the simplest case of
verifying a linear map's correctness.
"

Statement {F : Type} [Field F] {n : ℕ} (A : Matrix (Fin n) (Fin n) F) :
    A * 1 = A := by
  Hint "The identity `Matrix.mul_one` states A * 1 = A. Type: exact Matrix.mul_one A"
  exact Matrix.mul_one A

Conclusion
"
You proved that the identity matrix is a right-identity for matrix multiplication.
This is the Action stage: applying a known lemma directly.

In the next level, we move to determinants.
"

NewDefinition Matrix
