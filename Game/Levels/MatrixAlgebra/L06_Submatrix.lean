import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Defs
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 6

Title "Submatrices"

Introduction
"
## Submatrices

A **submatrix** is formed by selecting subsets of rows and columns from a matrix.
In Mathlib, `A.submatrix rowSub colSub` extracts the submatrix using functions
`rowSub : Fin m' → Fin m` and `colSub : Fin n' → Fin n`.

The **minor** of a matrix is the determinant of a square submatrix. Minors are
fundamental in the **Support-Minor** cryptographic model.

### Your Task

Prove that the transpose of a submatrix equals the submatrix of the transpose
(with the row/column functions swapped).

### Strategy

Use the lemma `Matrix.transpose_submatrix`.

### Cryptographic Context

In the **Support-Minor** model, an attacker tries to recover the secret key by finding
linear dependencies among minors of the public-key matrices. Understanding how
submatrices interact with transpose is essential for manipulating these structures.
"

Statement {F : Type} [Field F] {m n m' n' : ℕ}
    (A : Matrix (Fin m) (Fin n) F)
    (r : Fin m' → Fin m) (c : Fin n' → Fin n) :
    Matrix.transpose (A.submatrix r c) = (Matrix.transpose A).submatrix c r := by
  Hint "Use `Matrix.transpose_submatrix`. Type: exact Matrix.transpose_submatrix A r c"
  exact Matrix.transpose_submatrix A r c

Conclusion
"
Submatrices and minors are the mathematical objects underlying the Support-Minor
attack model. By treating a submatrix as a first-class object (not just a computation),
we enter the **Object** stage of APOS theory.

**APOS stage:** Object — submatrix extraction treated as a manipulable
construct, not just a computation.
"

NewDefinition Matrix.submatrix
