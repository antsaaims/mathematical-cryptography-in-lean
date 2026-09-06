import Game.Metadata
import Game.Levels.SecretSharing.L02_PolynomialRing
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Tactic.Ring

World "FinalExam"
Level 1

Title "Final Exam: Old Tools, Newest Ring"

Introduction
"
## The Question That Never Stops Being Worth Asking

Every world since Tutorial has occasionally asked: does `ring` still work
here? By now the answer is unsurprising — but UOV World's quotient ring
`AdjoinRoot f` (QR-UOV) is the newest ring this course introduced. Confirm
the pattern holds one last time.

### Your Task

Prove `(a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2` for elements `a`, `b` of
`AdjoinRoot f`, for any polynomial `f` over a field.

### Strategy

This is Tutorial World's very first `ring` identity — copied verbatim,
just instantiated at a ring you met for the first time near the end of the
course.
"

Statement (F : Type) [Field F] (f : Polynomial F) (a b : AdjoinRoot f) :
    (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by
  Hint (hidden := true) "Exactly the same tactic that closed this identity back in Tutorial World."
  ring

Conclusion
"
`AdjoinRoot f` is a commutative ring like every other one you've worked in
this semester — the theorem was never about the specific ring, and `ring`
proves it that way.

**Checkpoint cleared.**

**APOS stage:** N/A — a retrieval checkpoint, not new teaching content.
"
