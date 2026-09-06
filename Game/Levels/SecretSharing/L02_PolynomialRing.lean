import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Tactic.Ring

World "SecretSharing"
Level 2

Title "Old Tools, New Ring"

Introduction
"
## Does `ring` Still Work Here?

`Polynomial F` — polynomials with coefficients in a field `F` — is itself a
commutative ring, with its own `+`, `*`, and a distinguished element `X`
(the indeterminate). Every identity you've ever closed with `ring` was
really a fact about *any* commutative ring, `Polynomial F` included.

### Your Task

Prove `(X + 1) ^ 2 = X ^ 2 + 2 * X + 1` in `Polynomial (ZMod 5)`.

### Strategy

This is the exact same shape of identity from Tutorial World — just in a
ring whose elements are polynomials instead of numbers.
"

Statement : (Polynomial.X + 1 : Polynomial (ZMod 5)) ^ 2
    = Polynomial.X ^ 2 + 2 * Polynomial.X + 1 := by
  Hint "This closes exactly like every other commutative-ring identity you've proved. Type: ring"
  ring

Conclusion
"
`ring` doesn't care that its elements happen to be polynomials rather than
numbers — a commutative ring is a commutative ring. This is exactly why
Lagrange interpolation (built entirely from `+`, `*`, and `X`) can be
reasoned about with the same tools as everything else in this course.

**APOS stage:** Process — confirming an old, general tool transfers to a
new algebraic domain.
"

NewDefinition Polynomial
