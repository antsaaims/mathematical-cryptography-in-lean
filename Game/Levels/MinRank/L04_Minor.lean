import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Defs
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "MinRank"
Level 4

Title "Determinant of a Submatrix"

Introduction
"
## Minors

A **minor** of a matrix is the determinant of a square submatrix. If A is
m x n, a k x k minor is det(A_{S,T}) where S is a subset of [m],
T is a subset of [n], |S| = |T| = k. Crucially, a minor is usually *smaller*
than the original matrix — that's the whole point of the name.

In Mathlib, `A.submatrix r c` extracts a submatrix using selector functions
`r`, `c`; `(A.submatrix r c).det` is the corresponding minor.

### Cryptographic Context

In the **Support-Minor** model (a generalization of MinRank), the attacker
exploits the fact that if rank(M) <= r, then all (r+1) x (r+1) minors of M are zero.

### Your Task

The identity matrix on `Fin 3` has a genuine 2x2 minor: the top-left block,
selected by keeping rows/columns `0` and `1` and discarding row/column `2`.
Prove that this 2x2 minor equals `1`.

### Strategy

Every field involved here (`ZMod 5`) and every index (`Fin 3`, `Fin 2`) is
finite and concrete, so `decide` can just compute both the submatrix and its
determinant directly.
"

Statement :
    ((1 : Matrix (Fin 3) (Fin 3) (ZMod 5)).submatrix ![0, 1] ![0, 1]).det = 1 := by
  Hint "Every value here is concrete and finite — Lean can compute the whole thing. Type: decide"
  decide

Conclusion
"
Unlike selecting every row and column of a matrix (which is secretly the
whole matrix again, not a real submatrix), this one is genuinely smaller: a
2x2 minor cut out of a 3x3 matrix. It still comes out to `1`, because the
block you kept was itself an identity block.

This is the shape of a real Support-Minor computation: pick a subset of
rows and columns, form the determinant, and ask whether it vanishes.

**APOS stage:** Process — combining submatrix extraction and determinant
computation into a single concrete example.
"
