import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MinRank"
Level 3

Title "Determinant of a Scalar Multiple"

Introduction
"
## Scalar Multiples and Determinants

For an n x n matrix A and scalar lambda:

    det(lambda * A) = lambda^n * det(A)

This follows because scaling a matrix by lambda scales every row by lambda,
and the determinant is multilinear in the rows. (Lean states the exponent
as `Fintype.card (Fin n)` rather than the simplified `n` — the same number,
just written the fully general way Mathlib's lemma is stated for any
finite index type, not only `Fin n`.)

### Cryptographic Context

In MinRank, we study how the determinant of a linear combination Sum lambda_i M_i
depends on the coefficients lambda_i. The formula det(lambda * A) = lambda^n * det(A)
is the simplest case — a single matrix scaled by one coefficient.

### Your Task

Prove that det(lambda * A) = lambda^n * det(A) for an
n x n matrix.

### Strategy

Use the lemma `Matrix.det_smul`, which takes arguments in the order
`(A : Matrix n n R) (c : R)`.
"

Statement {F : Type} [Field F] {n : ℕ}
    (c : F) (A : Matrix (Fin n) (Fin n) F) :
    (c • A).det = c ^ Fintype.card (Fin n) * A.det := by
  Hint "Use `Matrix.det_smul` which gives det(c • A) = c^n * det(A)."
  Hint "Type: exact Matrix.det_smul A c"
  exact Matrix.det_smul A c

Conclusion
"
The formula det(lambda * A) = lambda^n * det(A) is a special case of how
determinants interact with linear algebra operations.

In MinRank, the determinant of Sum lambda_i M_i is a polynomial in the
lambda_i. Finding coefficients that make this polynomial zero is the core
algebraic challenge.

**APOS stage:** Process — a general law describing how determinant behaves
under scaling, for every matrix and scalar at once.
"
