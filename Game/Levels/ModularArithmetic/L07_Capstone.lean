import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Group.Defs
import Mathlib.Tactic.Common

World "ModularArithmetic"
Level 7

Title "Capstone: Diffie-Hellman Key Exchange Correctness"

Introduction
"
## Synthesis: Why Diffie-Hellman Works

Here is the full picture. Alice and Bob publicly agree on a generator `g` in
`ZMod n`. Each picks a secret natural number:

- Alice picks secret `a`, sends `g ^ a` to Bob.
- Bob picks secret `b`, sends `g ^ b` to Alice.

Alice then computes `(g ^ b) ^ a` using Bob's message and her own secret.
Bob computes `(g ^ a) ^ b` using Alice's message and his own secret. For the
key exchange to work at all, these two computations — done independently, by
two different people, without either learning the other's secret — must
produce the **same** shared secret.

This is the **Schema** stage: combining the exponent law (Process) and the
multiplicative structure of powers (Object) into the single cryptographic
guarantee that makes a real protocol correct.

### Your Task

Prove that Alice and Bob really do compute the same value.

### Strategy

Rewrite each side with the exponent law from Level 3 (in reverse, to combine
two powers into one), then finish with commutativity of multiplication on
the exponents.
"

Statement {n : ℕ} (g : ZMod n) (a b : ℕ) : (g ^ a) ^ b = (g ^ b) ^ a := by
  Hint "Combine each side into a single power using `pow_mul` in reverse. Type: rw [← pow_mul, ← pow_mul]"
  rw [← pow_mul, ← pow_mul]
  Hint "Both sides are now g raised to a product of a and b in some order — finish with `mul_comm`. Type: rw [mul_comm]"
  rw [mul_comm]

Conclusion
"
Congratulations — you've completed the Modular Arithmetic World!

You proved, from first algebraic principles, exactly why Diffie–Hellman key
exchange works: `(g^a)^b = (g^b)^a` because multiplication of natural-number
exponents commutes. This tiny identity, at cryptographic scale (huge `n`,
huge secrets), is what lets two strangers agree on a shared secret over a
public channel.

Next: **Groups and Orders World**, where `ZMod n` stops being just a ring
to compute in and becomes an object of study — the vocabulary (element
order, generators, the Chinese Remainder Theorem) that Public-Key
Cryptography World assumes you already have.

**APOS stage:** Schema — the exponent law from Level 3, synthesized into a
real protocol's correctness guarantee.
"
