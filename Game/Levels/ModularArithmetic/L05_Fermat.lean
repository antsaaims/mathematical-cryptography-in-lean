import Game.Metadata
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Tactic.Common

World "ModularArithmetic"
Level 5

Title "Fermat's Little Theorem"

Introduction
"
## A Theorem That Powers RSA

You've been raising elements of `ZMod n` to powers since Level 2. Here is
the single deepest fact about that operation, when the modulus is *prime*:
for any nonzero `a` in `ZMod p`, raising `a` to the power `p - 1` always
gives back `1` — no matter which nonzero `a` you started with.

This is **Fermat's Little Theorem**. It is not obvious from the ring axioms
alone; it's a genuine number-theoretic fact about how multiplication mixes
the nonzero elements of `ZMod p` around.

### Your Task

Prove Fermat's Little Theorem: for a prime `p` and nonzero `a : ZMod p`,
`a ^ (p - 1) = 1`.

### Strategy

Mathlib already has this exact theorem.
"

Statement (p : ℕ) [Fact p.Prime] (a : ZMod p) (ha : a ≠ 0) : a ^ (p - 1) = 1 := by
  Hint "This is exactly Mathlib's statement of Fermat's Little Theorem. Type: exact ZMod.pow_card_sub_one_eq_one ha"
  exact ZMod.pow_card_sub_one_eq_one ha

Conclusion
"
Every nonzero element of `ZMod p`, raised to the `(p-1)`-th power, collapses
to `1`. Next level generalizes this from a prime modulus to *any* modulus —
which is exactly the fact RSA's correctness rests on.

**APOS stage:** Object — a single deep theorem, used as a black-box tool
rather than something you'd reprove from scratch each time.
"

NewTheorem ZMod.pow_card_sub_one_eq_one
