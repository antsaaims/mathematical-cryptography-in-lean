import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Defs
import Mathlib.Tactic.Common

World "MinRank"
Level 5

Title "The Zero Matrix Has All Zero Minors"

Introduction
"
## Support-Minor Model

The **Support-Minor** model extends MinRank by working with minors directly.
The key insight is:

If rank(M) <= r, then all (r+1) x (r+1) minors of M are zero.

The converse also holds (over a field): if all (r+1) x (r+1) minors vanish,
then rank(M) <= r.

### Your Task

Prove the base case: the zero matrix is its own submatrix (up to the selection
functions), establishing that zero matrices have trivially zero minors.

Prove that `(0 : Matrix).submatrix r c = 0`.

### Strategy

Use `Matrix.submatrix_zero` which states that the submatrix of a zero matrix
is the zero matrix.
"

Statement {F : Type} [Field F] {m n m' n' : ℕ}
    (r : Fin m' → Fin m) (c : Fin n' → Fin n) :
    (0 : Matrix (Fin m) (Fin n) F).submatrix r c = 0 := by
  Hint "The submatrix of a zero matrix is zero. Use `Matrix.submatrix_zero`."
  Hint "Type: rfl"
  rfl

Conclusion
"
The zero matrix has all zero submatrices, hence all zero minors. This is the
trivial case of the Support-Minor principle.

In the non-trivial case, the attacker searches for linear combinations of public-key
matrices whose minors vanish — revealing the secret key structure.

**APOS stage:** Object — treating 'the minors of M' as a structured object with
its own vanishing behavior, the basis of the Support-Minor model.
"

NewTactic exact
