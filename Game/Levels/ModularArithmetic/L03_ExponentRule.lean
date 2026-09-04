import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Group.Defs
import Mathlib.Tactic.Common

World "ModularArithmetic"
Level 3

Title "The Law Behind Diffie-Hellman"

Introduction
"
## From One Example to the General Law

Checking `2 ^ 4 = 1 (mod 5)` tells you nothing about `2 ^ 7` or `3 ^ 4`. What
we actually need is a *law* that holds for every base and every pair of
exponents:

    g ^ (a * b) = (g ^ a) ^ b

Raising to a power and then raising the result to another power is the same
as raising once to the product of the two powers. This single law, applied
twice, is the entire algebraic engine behind Diffie–Hellman key exchange.

### Your Task

Prove this exponent law for an arbitrary `g : ZMod n` and natural numbers
`a b`.

### Strategy

This is such a fundamental fact about powers in any monoid that Mathlib has
already proved it once and for all, as `pow_mul`.
"

Statement {n : ℕ} (g : ZMod n) (a b : ℕ) : g ^ (a * b) = (g ^ a) ^ b := by
  Hint "This exact law is the Mathlib lemma `pow_mul`. Type: exact pow_mul g a b"
  exact pow_mul g a b

Conclusion
"
This is the **Process** stage: instead of checking `g ^ (a*b) = (g^a)^b` for
one `g`, `a`, `b` at a time, you now have a single reusable rule that Lean
(via Mathlib) has already established for every commutative ring element and
every pair of natural-number exponents.
"
