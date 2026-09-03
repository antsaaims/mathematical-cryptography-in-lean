import Game.Metadata
import Mathlib.Tactic.Common

World "Tutorial"
Level 2

Title "The Exact Tactic"

Introduction
"
## The `exact` Tactic

The **`exact`** tactic closes a goal by providing a term that has exactly the right type.

If your goal is `P` and you have a hypothesis `h : P`, then `exact h` finishes the proof.
Think of it as saying: I have exactly what is needed, right here.

### Your Task

You are given a hypothesis `h : x = y` and your goal is to prove `x = y`.

Simply use `exact h` to close the goal.

### Mathematical Context

In cryptographic proofs, we often reduce a complex verification to a single known
identity. When the goal exactly matches a hypothesis or previously proved result,
`exact` is the way to close it.
"

Statement {U : Type} (x y : U) (h : x = y) : x = y := by
  Hint "Your hypothesis `h` is exactly the goal. Type: exact h"
  exact h

Conclusion
"
The `exact` tactic is the simplest closing tactic. It will be your go-to move when
the goal is already present among your hypotheses.

In the UOV signature scheme, the final verification step often reduces to an identity
that is directly available, and `exact` closes the proof.
"

NewTactic exact
