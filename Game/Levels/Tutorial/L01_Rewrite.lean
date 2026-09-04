import Game.Metadata
import Mathlib.Tactic.Common

World "Tutorial"
Level 1

Title "Your First Rewrite"

Introduction
"
## The `rw` Tactic

The most fundamental tactic in Lean is **`rw`** (rewrite). It replaces one side of an
equality with the other side throughout your goal.

Suppose you have a hypothesis `h : x = 2` and your goal is to prove `x + x = 4`.
You can `rw [h]` to turn every occurrence of `x` into `2`, reducing the goal to `2 + 2 = 4`.

### Your Task

You are given:
- `h : x = 2` (x equals 2)
- `g : y = 4` (y equals 4)

Prove that `x + x = y`.

### Strategy

1. Use `rw [h]` to replace `x` with `2`.
2. Use `rw [g]` to replace `y` with `4`.
3. The goal becomes `2 + 2 = 4`, which Lean can verify automatically.

Equivalently, you could rewrite `y` first using `rw [g]`, then `x` using `rw [h]`.
"

Statement (x y : ℕ) (h : x = 2) (g : y = 4) : x + x = y := by
  Hint "Start by rewriting `x` to `2` using your hypothesis `h`. Type: rw [h]"
  rw [h]
  Hint "Now rewrite `y` to `4` using your hypothesis `g`. Type: rw [g]"
  rw [g]

Conclusion
"
Excellent! You just proved your first Lean theorem using `rw`.

In cryptography, we constantly substitute known values (keys, signatures, hashes)
into equations to verify correctness. The `rw` tactic is the Lean analogue of this
substitution step.

**APOS stage:** Action — a single, explicit, mechanical step.
"

NewTactic rw
NewDefinition Nat
