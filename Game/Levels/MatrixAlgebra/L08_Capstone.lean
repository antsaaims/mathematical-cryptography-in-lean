import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 8

Title "Capstone: The Rank-Determinant Connection"

Introduction
"
## Capstone: Putting It All Together

You proved two facts about the identity matrix in this world that sound
unrelated: `det(1) = 1` (Level 3) and `rank(1) = n` (Level 7). They are not
a coincidence. This level formalizes one genuine link, over a field: a
square matrix is invertible exactly when its determinant is a unit
(nonzero) — `Matrix.isUnit_iff_isUnit_det`, applied below to the identity.
The second link, that a matrix is invertible exactly when it has full
rank, is equally real and standard, but this course states it as
background rather than proving it — so what you're about to formalize is
the invertible/determinant half of the three-way picture, not all of it.

### Cryptographic Significance

The **MinRank problem** asks: given matrices M_1, ..., M_k and a target rank r,
find scalars lambda_1, ..., lambda_k (not all zero) such that:

    rank(Sum lambda_i M_i) <= r

An attacker who finds such a combination has found a *non-generic*, structured
linear combination — exactly what the invertible/singular boundary you're
about to formalize is used to detect.

### Your Task

Prove that the identity matrix's determinant is a unit — i.e. transfer the
(trivial) fact that the identity matrix is itself invertible onto its
determinant.

### Strategy

`Matrix.isUnit_iff_isUnit_det` says a matrix is a unit exactly when its
determinant is. Apply it to the (already-known) fact that `1` is a unit.
"

Statement {F : Type} [Field F] {n : ℕ} :
    IsUnit (1 : Matrix (Fin n) (Fin n) F).det := by
  Hint "Transfer invertibility of the identity matrix onto its determinant. Type: exact (Matrix.isUnit_iff_isUnit_det 1).mp isUnit_one"
  exact (Matrix.isUnit_iff_isUnit_det 1).mp isUnit_one

Conclusion
"
Congratulations! You have completed the Matrix Algebra World.

You now understand matrices, determinants, transposes, rank, and submatrices —
the fundamental objects of algebraic cryptography. The invertible/nonzero-
determinant equivalence you just formalized (and the full-rank equivalence
this course states but doesn't prove) is the mathematical foundation of the
MinRank and Support-Minor attacks: they search for combinations that *fail*
this equivalence in a structured way.

Next: **MinRank World** unlocks now — it needs only this world. **UOV World**
also unlocks from here, but its final capstone additionally needs the
Secret Sharing Exam, so start that independent track too if you haven't.
MinRank formalizes the attack that targets schemes like the one UOV proves
correct.

**APOS stage:** Schema — combining the determinant (Levels 1–4), transpose and
submatrix (Levels 5–6), and rank (Level 7) material from this world into the
invertible/determinant equivalence (the full-rank equivalence remains stated,
not formalized).
"

NewTheorem Matrix.isUnit_iff_isUnit_det
