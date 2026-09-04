import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "ModularArithmetic"
Level 2

Title "Modular Exponentiation"

Introduction
"
## Repeated Multiplication

Exponentiation `a ^ e` is just repeated multiplication: `a * a * ... * a`
(`e` times). Both **Diffie–Hellman** and **RSA** are built entirely out of
modular exponentiation: real implementations use huge numbers, but the
underlying operation — and everything you'll prove about it — is exactly
what you see here at small scale.

For example, `2 ^ 4 = 16`, and `16 ≡ 1 (mod 5)`.

### Your Task

Check this concrete example in `ZMod 5`.

### Strategy

Another finite computation — `decide` handles it.
"

Statement : (2 : ZMod 5) ^ 4 = 1 := by
  Hint "Concrete modular exponentiation — compute and compare. Type: decide"
  decide

Conclusion
"
Small numbers here, but real Diffie–Hellman and RSA implementations perform
exactly this operation on numbers hundreds of digits long — computed
efficiently by *fast* exponentiation, never one multiplication at a time.
"
