import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Defs
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MinRank"
Level 4

Title "Determinant of a Submatrix"

Introduction
"
## Minors

A **minor** of a matrix is the determinant of a square submatrix. If A is
m x n, a k x k minor is det(A_{S,T}) where S is a subset of [m],
T is a subset of [n], |S| = |T| = k.

In Mathlib, `A.submatrix r c` extracts a submatrix, and `(A.submatrix r c).det`
is the corresponding minor.

### Cryptographic Context

In the **Support-Minor** model (a generalization of MinRank), the attacker
exploits the fact that if rank(M) <= r, then all (r+1) x (r+1) minors of M are zero.

### Your Task

Prove that the determinant of the identity submatrix (selecting all rows and columns
of the identity) equals 1.

### Strategy

The submatrix of the identity with identity row/column functions is the identity.
Use `Matrix.submatrix_id_id` to simplify, then `Matrix.det_one`.
"

Statement {F : Type} [Field F] {n : ℕ} :
    ((1 : Matrix (Fin n) (Fin n) F).submatrix id id).det = 1 := by
  Hint "Simplify the submatrix of identity with identity functions."
  Hint "Type: rw [Matrix.submatrix_id_id]"
  rw [Matrix.submatrix_id_id]
  Hint "Now use det_one. Type: exact Matrix.det_one"
  exact Matrix.det_one

Conclusion
"
The determinant of the identity submatrix (with identity selection functions) is 1.
This confirms that minors of full-rank matrices are non-zero, which is the key
property used in Support-Minor attacks.

**APOS stage:** Process — combining two general simplification laws in sequence
rather than a single mechanical step.
"

NewTactic rw exact
NewDefinition Matrix.submatrix
