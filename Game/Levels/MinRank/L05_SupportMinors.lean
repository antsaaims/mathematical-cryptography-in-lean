import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Defs
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MinRank"
Level 5

Title "The Zero Matrix Has All Zero Minors"

Introduction
"
## Support-Minor Model

The **Support-Minor** model extends MinRank by working with minors directly —
recall from Level 4 that a minor is the determinant of a (usually smaller)
square submatrix. The key insight is:

If rank(M) <= r, then all (r+1) x (r+1) minors of M are zero.

The converse also holds (over a field): if all (r+1) x (r+1) minors vanish,
then rank(M) <= r.

### Your Task

Prove the base case: *every* square minor of the zero matrix — of any size
`k`, cut out by any row/column selectors `r`, `c` — is `0`.

### Strategy

First reduce the submatrix of a zero matrix to the zero matrix
(`Matrix.submatrix_zero`), then use the fact that a zero matrix has
determinant `0` (`Matrix.det_zero`, the same lemma from Level 2 — it needs
the k x k block to be nonempty, which `[NeZero k]` supplies).
"

Statement {F : Type} [Field F] {n k : ℕ} [NeZero k]
    (r c : Fin k → Fin n) :
    ((0 : Matrix (Fin n) (Fin n) F).submatrix r c).det = 0 := by
  Hint "First reduce the submatrix of the zero matrix to the zero matrix. Type: rw [Matrix.submatrix_zero]"
  rw [Matrix.submatrix_zero]
  Hint "Now use the fact that a (nonempty) zero matrix has determinant zero, exactly as in Level 2. Type: simp [Matrix.det_zero]"
  simp [Matrix.det_zero]

Conclusion
"
The zero matrix has all zero minors, at every size `k` — the trivial case of
the Support-Minor principle, but now stated the way the theory actually uses
it: as a fact about *determinants of submatrices*, not just submatrices.

In the non-trivial case, the attacker searches for linear combinations of public-key
matrices whose minors vanish — revealing the secret key structure.

**APOS stage:** Object — treating 'the minors of M' as a structured object with
its own vanishing behavior, the basis of the Support-Minor model.
"
