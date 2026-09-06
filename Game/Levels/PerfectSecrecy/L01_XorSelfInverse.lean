import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "PerfectSecrecy"
Level 1

Title "XOR Is Its Own Inverse"

Introduction
"
## Bits Are Just Modular Arithmetic Again

A bit is an element of `ZMod 2` — arithmetic modulo 2, the smallest ring
you've worked with yet. Addition in `ZMod 2` is exactly the **XOR**
operation on bits: `0+0=0`, `0+1=1`, `1+0=1`, and `1+1=0` (the '1' carries
away, since we're working mod 2).

That last case is the important one: adding a bit to *itself* always gives
`0`. Every element of `ZMod 2` is its own additive inverse.

### Your Task

Prove that every bit `a` satisfies `a + a = 0`.

### Strategy

`ZMod 2` has only two elements — Lean can just check both.
"

/-- Every bit is its own additive inverse: `a + a = 0` in `ZMod 2`. -/
Statement xor_self_zero : ∀ a : ZMod 2, a + a = 0 := by
  Hint "Only two possible values for `a` — let Lean check them all. Type: decide"
  decide

Conclusion
"
`a + a = 0` for every bit `a`. This one small fact is the entire engine of
the **one-time pad**: whatever a key does to a message, applying the *same*
key again undoes it completely — because the key cancels with itself.

**APOS stage:** Action — a single, mechanical, fully-decidable check.
"
