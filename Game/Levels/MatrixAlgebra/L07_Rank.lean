import Game.Metadata
import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 7

Title "The Rank of the Identity"

Introduction
"
## Rank

The **rank** of a matrix is, informally, the number of genuinely independent
rows (equivalently, columns) it has — the dimension of the space it maps
onto. In Mathlib, `Matrix.rank A` makes this precise for any matrix `A`.

The identity matrix `1 : Matrix (Fin n) (Fin n) F` should be the most
'independent' matrix possible: none of its rows can be built out of the
others. Its rank should be the full `n`.

### Your Task

Prove that the `n × n` identity matrix has rank `n`.

### Strategy

`Matrix.rank_one` gives the rank of the identity as `Fintype.card (Fin n)`;
`Fintype.card_fin` simplifies that count to `n`.
"

Statement {F : Type} [Field F] {n : ℕ} :
    Matrix.rank (1 : Matrix (Fin n) (Fin n) F) = n := by
  Hint "Start from the rank of the identity matrix. Type: rw [Matrix.rank_one]"
  rw [Matrix.rank_one]
  Hint "Simplify the count of `Fin n` down to `n`. Type: rw [Fintype.card_fin]"
  rw [Fintype.card_fin]

Conclusion
"
The identity matrix has full rank `n` — exactly as many independent rows as
it has rows at all. Recall from Level 3 that `det(1) = 1` too: these are two
different ways of saying the same thing about the identity, a connection
this world's capstone makes precise.

In **MinRank**, the whole attack is about finding matrix combinations whose
rank *drops* — the opposite of what you just proved about the identity.

**APOS stage:** Object — rank is a single number encapsulating a whole
matrix's independence structure, not a step-by-step computation.
"

NewDefinition Matrix.rank
