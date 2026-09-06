import Game.Metadata
import Game.Levels.SecretSharing.L02_PolynomialRing
import Mathlib.Tactic.Ring

World "SecretSharingExam"
Level 1

Title "Exam: Another Polynomial Identity"

Introduction
"
## Checkpoint: Old Tools, New Ring

A different identity this time, same question as Level 2: does `ring`
still work?
"

Statement : (Polynomial.X - 1 : Polynomial (ZMod 7)) * (Polynomial.X + 1)
    = Polynomial.X ^ 2 - 1 := by
  Hint (hidden := true) "Nothing new — the same tactic that closed Level 2."
  ring

Conclusion
"
**Checkpoint cleared.**

**APOS stage:** N/A — a retrieval checkpoint, not new teaching content.
"
