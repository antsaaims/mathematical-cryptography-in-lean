import Game.Metadata
import Game.Levels.MatrixAlgebra.L08_Capstone
import Game.Levels.MatrixAlgebra.L07_Rank
import Mathlib.Tactic.Common

World "FinalExam"
Level 2

Title "Final Exam: The Identity, Three Ways at Once"

Introduction
"
## Recall, Don't Re-Derive

Matrix Algebra World proved three separate facts about the identity
matrix: `det(1) = 1` (Level 3), `rank(1) = n` (Level 7), and
`IsUnit (1).det` (the capstone). Combine two of them here without being
walked through it.

### Your Task

Given that `Matrix.rank (1 : Matrix (Fin n) (Fin n) F) = n`, prove
`IsUnit (1 : Matrix (Fin n) (Fin n) F).det`.

### Strategy

The rank hypothesis isn't actually needed to reach the conclusion — notice
that, and reuse the fact you already proved for exactly this matrix.
"

Statement {F : Type} [Field F] {n : ℕ} (h : Matrix.rank (1 : Matrix (Fin n) (Fin n) F) = n) :
    IsUnit (1 : Matrix (Fin n) (Fin n) F).det := by
  Hint (hidden := true) "The hypothesis `h` is a distraction — this exact conclusion, for exactly this matrix, was Matrix Algebra World's capstone."
  exact (Matrix.isUnit_iff_isUnit_det 1).mp isUnit_one

Conclusion
"
Real exam questions (and real research papers) sometimes hand you more
information than any single step needs — part of the skill is recognizing
which fact actually applies.

**Checkpoint cleared.**

**APOS stage:** N/A — a retrieval checkpoint, not new teaching content.
"
