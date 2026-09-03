import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 2

Title "Determinant of the Identity"

Introduction
"
## Determinants

The **determinant** of a square matrix `A`, written `A.det` (or `Matrix.det A`),
is a scalar that encodes key geometric properties:

- `det(A) = 0` if and only if `A` is singular (non-invertible).
- `det(A * B) = det(A) * det(B)`.
- `det(I) = 1`.

In Mathlib, `Matrix.det` is defined for `Matrix (Fin n) (Fin n) F`.

### Your Task

Prove that the determinant of the identity matrix is `1`.

### Strategy

The lemma `Matrix.det_one` states `det(1) = 1`. Use `exact`.

### Cryptographic Context

In **MinRank**, we seek a linear combination of matrices whose determinant is zero
(i.e., the combination is singular). Understanding that `det(I) = 1` establishes the
baseline: the identity is the farthest thing from singular.
"

Statement {F : Type} [Field F] {n : ℕ} :
    (1 : Matrix (Fin n) (Fin n) F).det = 1 := by
  Hint "The lemma `Matrix.det_one` gives det(1) = 1. Type: exact Matrix.det_one"
  exact Matrix.det_one

Conclusion
"
The determinant of the identity is 1 — the simplest non-trivial determinant fact.
In the MinRank problem, we search for combinations where the determinant drops to 0,
indicating a rank deficiency.
"

NewTactic exact
NewDefinition Matrix.det
