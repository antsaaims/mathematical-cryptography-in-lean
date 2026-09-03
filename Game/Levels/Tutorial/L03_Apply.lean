import Game.Metadata
import Mathlib.Tactic.Common

World "Tutorial"
Level 3

Title "Forward and Backward with apply"

Introduction
"
## The `apply` Tactic

The **`apply`** tactic works *backwards*. If your goal is `Q` and you know a theorem
`h : P implies Q`, then `apply h` changes the goal from `Q` to `P`.

### Example

If your goal is `b` and you have `h : a implies b`, then `apply h` changes the goal to `a`.

This is like working backwards in a proof: To prove Q, it suffices to prove P, because
P implies Q.

### Your Task

Given:
- `h : a implies b` (h states that a implies b)
- `ha : a` (we know a is true)

Prove `b`.

### Strategy

1. Use `apply h` to reduce the goal from `b` to `a`.
2. Use `exact ha` to close the remaining goal.
"

Statement (a b : Prop) (h : a → b) (ha : a) : b := by
  Hint "To prove `b`, it suffices to prove `a` since `h : a → b`. Type: apply h"
  apply h
  Hint "Now prove `a` using your hypothesis `ha`. Type: exact ha"
  exact ha

Conclusion
"
The `apply` tactic is central to structured proof. In cryptographic security proofs,
we frequently chain implications: if the adversary wins, then this game reduces to
that game, which implies a computational assumption is broken.

Each `apply` is one link in that chain.
"

NewTactic apply
