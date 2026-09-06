import Game.Metadata
import Game.Levels.PublicKeyCrypto.L02_ModEqToolkit
import Mathlib.Tactic.Common

World "PublicKeyExam"
Level 2

Title "Exam: Combining Two Independent Congruences"

Introduction
"
## Checkpoint: The ModEq Toolkit

Public-Key Cryptography World's toolkit level combined a congruence with
*itself* (the same `a ≡ b` used for both the power step and the
multiplication step). This time, you're given two genuinely *different*
congruences to combine into one.

### Your Task

Given `a ≡ b [MOD n]` and `c ≡ d [MOD n]`, prove `a * c ^ 2 ≡ b * d ^ 2 [MOD n]`.

### Strategy

You'll need a congruence-combinator that hasn't been named for you yet —
one that multiplies two *different* congruences together rather than a
congruence by a fixed constant.
"

Statement (a b c d n : ℕ) (h1 : a ≡ b [MOD n]) (h2 : c ≡ d [MOD n]) :
    a * c ^ 2 ≡ b * d ^ 2 [MOD n] := by
  Hint (hidden := true) "First raise `h2` to the power 2."
  have hp : c ^ 2 ≡ d ^ 2 [MOD n] := Nat.ModEq.pow 2 h2
  Hint (hidden := true) "Now combine `h1` and `hp` — look for a `Nat.ModEq` combinator that multiplies two different congruences together, not just a congruence by a constant."
  exact Nat.ModEq.mul h1 hp

Conclusion
"
`Nat.ModEq.mul` combines two independent congruences at once — a genuine
generalization of `mul_left`, which was really just `Nat.ModEq.mul` with
one side already reflexively equal to itself.

**Public-Key checkpoint complete.**

**APOS stage:** N/A — a retrieval checkpoint generalizing a prior level's
toolkit, not new teaching content.
"

NewTheorem Nat.ModEq.mul
