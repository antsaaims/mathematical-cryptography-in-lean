import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "ModularArithmetic"
Level 1

Title "Modular Multiplicative Inverses"

Introduction
"
## Beyond Addition

The Caesar cipher only ever *added* a shift. Modern cryptosystems like RSA
and Diffie–Hellman are built on *multiplication* and *exponentiation* modulo
some number `n`, in the ring `ZMod n`.

A **multiplicative inverse** of `a` modulo `n` is a number `b` with
`a * b ≡ 1 (mod n)`. For example, `3` and `5` are multiplicative inverses
modulo `7`, since `3 * 5 = 15 = 2*7 + 1 ≡ 1 (mod 7)`.

### Your Task

Check this concrete example directly in `ZMod 7`.

### Strategy

Just like Caesar-cipher arithmetic, this is a finite computation that
`decide` can check directly.
"

Statement : (3 : ZMod 7) * 5 = 1 := by
  Hint "Concrete ZMod arithmetic — compute and compare. Type: decide"
  decide

Conclusion
"
Multiplicative inverses are what let you 'divide' inside `ZMod n` even though
there's no division operator — and RSA decryption is fundamentally about
finding the right inverse exponent.
"
