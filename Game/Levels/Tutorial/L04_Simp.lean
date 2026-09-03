import Game.Metadata
import Mathlib.Tactic.Common

World "Tutorial"
Level 4

Title "Automation with simp"

Introduction
"
## The `simp` Tactic

The **`simp`** tactic automatically simplifies the goal using a large database of
simplification lemmas. It is your auto-pilot for routine algebraic steps.

### How It Works

`simp` rewrites terms using identities like:
- `a + 0 = a`
- `a * 1 = a`
- `n + 0 = n`

It keeps applying these rules until no more simplifications are possible.

### Your Task

Prove that for any natural number `n`, we have `n + 0 = n`.

This is trivially true by the definition of addition, and `simp` handles it
automatically.

### Mathematical Context

In multivariate cryptography, polynomial systems often have trivial simplifications
(removing zero terms, multiplying by one). The `simp` tactic automates these
bookkeeping steps so you can focus on the interesting mathematics.
"

Statement (n : ℕ) : n + 0 = n := by
  Hint "The `simp` tactic can close this goal automatically. Type: simp"
  simp

Conclusion
"
`simp` is powerful but not omniscient. It excels at routine simplifications but may
not find deep structural arguments. Use it for cleanup, then switch to targeted tactics
for the hard parts.

In the UOV world, you will use `simp` to simplify polynomial evaluations after
substituting oil and vinegar variables.
"

NewTactic simp
