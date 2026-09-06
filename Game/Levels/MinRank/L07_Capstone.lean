import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MinRank"
Level 7

Title "Capstone: The MinRank Identity"

Introduction
"
## Capstone: MinRank Key Identity

The MinRank problem seeks lambda_1, lambda_2 such that
det(lambda_1 * A + lambda_2 * B) = 0 (for the rank-deficient case with 2 matrices).

A key algebraic identity used in MinRank solvers is the **multilinearity** of the
determinant in the matrix argument. Specifically, for a scalar lambda:

    det(lambda * A) = lambda^n * det(A)

When det(A) = 0 (i.e., A is already singular), then det(lambda * A) = 0
for any lambda. This is why rank-deficient matrices are the targets in MinRank.

### Your Task

Prove: if det(A) = 0, then det(lambda * A) = 0.

### Strategy

1. Use `Matrix.det_smul` to rewrite `(lambda * A).det` as `lambda^n * A.det`.
2. Rewrite `A.det` to `0` using the hypothesis `h`.
3. Simplify `lambda^n * 0` to `0` using `mul_zero`.
"

Statement {F : Type} [Field F] {n : ℕ}
    (c : F) (A : Matrix (Fin n) (Fin n) F)
    (h : A.det = 0) :
    (c • A).det = 0 := by
  Hint "Step 1: Rewrite det(c • A) = c^Fintype.card (Fin n) * det(A). Type: rw [Matrix.det_smul]"
  rw [Matrix.det_smul]
  Hint "Step 2: Substitute det(A) = 0 using hypothesis h. Type: rw [h]"
  rw [h]
  Hint "Step 3: Simplify c^n * 0 to 0. Type: rw [mul_zero]"
  rw [mul_zero]

Conclusion
"
**Congratulations!** You have completed the MinRank World!

You just proved the **MinRank key identity**: if a matrix A is singular
(det(A) = 0), then any scalar multiple lambda * A is also singular.

Here is precisely why this is an attack, not just an algebra fact. Recall
from UOV World that a multivariate scheme's central map is, per output
coordinate, a quadratic map built from a bilinear map — in coordinates, a
matrix (`B.toQuadraticMap x = B x x`). A public key made of `m` such
quadratic forms therefore comes with `m` matrices, `M_1, ..., M_m`, one per
output coordinate. For schemes built like **HFE** (Hidden Field Equations),
the *secret* structure forces some linear combination `lambda_1 M_1 + ... +
lambda_m M_m` of those matrices to have unusually low rank — an accident
that would essentially never happen for `m` genuinely random matrices.

**MinRank attacks** search for exactly that combination:
- The attacker searches for lambda_i making `Sum lambda_i M_i` singular
  (or low-rank).
- Finding it recovers information about the secret structure the scheme
  was trying to hide.
- The determinant (or the vanishing of low-order minors) becomes a
  polynomial condition in the lambda_i, turning key recovery into solving
  a system of polynomial equations.

Both sources behind this world agree on this precise mechanism
independently: Ding and Petzoldt's survey describes MinRank as searching
for 'a linear combination of the quadratic forms... of low rank,' and
Varjabedian's 2026 thesis (Ch. 3.2.1, 'Key recovery attacks with MinRank')
gives the same account for HFE specifically — and adds a striking
historical note: one particular MinRank variant ('MinRank S') wasn't found
until years after the schemes it attacks were already designed, and its
discovery broke GeMSS, an HFE-based scheme submitted to NIST's post-quantum
competition (and eliminated because of exactly this kind of attack) — a
genuinely counter-intuitive result the thesis itself highlights as
surprising.

## What This World Covered

You have formalized the key algebraic identity behind MinRank attacks —
scaling a singular matrix keeps it singular — and, in the level before this
one, the concrete determinant-of-a-submatrix mechanics the Support-Minor
model builds on. MinRank World stands on Matrix Algebra World alone; if
you reached this Conclusion without playing UOV World, that's by design —
they're independent tracks, not a sequence.

**MinRank World is complete.** If UOV World and the Public-Key Exam are
also done, the **Final Exam** is unlocked, and interleaves this world's
central identity with every other track's tools. If not, those are worth
finishing before this course is genuinely done.

**APOS stage:** Schema — synthesizing the Action (Level 1-2), Process (Level 3-4),
and Object (Level 5-6) material from this entire world into the single identity
that powers MinRank attacks.
"
