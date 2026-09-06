import Game.Metadata
import Game.Levels.GroupsAndOrders.L05_Capstone
import Mathlib.Tactic.Common

World "NumberTheoryExam"
Level 2

Title "Exam: Every Element, Not Just Generators"

Introduction
"
## Checkpoint: Groups and Orders World

Groups and Orders World's capstone proved `g ^ Fintype.card G = 1`, but
only for a `g` you were *given* to be a generator. Is the generator
hypothesis actually necessary?

### Your Task

Prove `x ^ Fintype.card G = 1` for an *arbitrary* element `x` — no
generator hypothesis at all this time.

### Strategy

You proved this exact conclusion once already, for a special case. Mathlib
has a lemma with an almost identical name to `pow_orderOf_eq_one` for
precisely this more general fact — look for it.
"

Statement {G : Type} [Group G] [Fintype G] (x : G) : x ^ Fintype.card G = 1 := by
  Hint (hidden := true) "Search for a lemma named like `pow_orderOf_eq_one`, but about `Fintype.card` instead of `orderOf`."
  exact pow_card_eq_one

Conclusion
"
Every element of a finite group, generator or not, satisfies
`x ^ Fintype.card G = 1` — Lagrange's Theorem in its most direct form. The
'generator' hypothesis in the previous capstone was never load-bearing for
*this* particular conclusion; it only mattered for the (stronger) claim
that repeating `g` visits every element of `G`.

**Number Theory checkpoint complete.** Public-Key Cryptography, Secret
Sharing, and Matrix Algebra Worlds all unlock now — in any order you like.

**APOS stage:** N/A — a retrieval checkpoint, not new teaching content.
"

NewTheorem pow_card_eq_one
