import Game.Metadata
import Mathlib.Data.Nat.ModEq
import Mathlib.Tactic.Common

World "PublicKeyCrypto"
Level 2

Title "Building Congruences From Congruences"

Introduction
"
## Combining Facts, Not Just Numbers

So far, every congruence (`≡ [MOD n]`) you've worked with came from a
single named theorem (Fermat, Euler). Real RSA proofs need to *combine*
congruences: if you know `a ≡ b (mod n)`, you can safely raise both sides
to a power, or multiply both sides by the same thing, and the congruence
survives.

### Your Task

Given `a ≡ b [MOD n]`, prove that `c * a ^ k ≡ c * b ^ k [MOD n]` for any
`c` and `k`.

### Strategy

First lift the congruence through the exponent `k`, then multiply both
sides by `c`.
"

Statement (a b c n k : ℕ) (h : a ≡ b [MOD n]) : c * a ^ k ≡ c * b ^ k [MOD n] := by
  Hint "First raise both sides of `h` to the power `k`. Type: have hp : a ^ k ≡ b ^ k [MOD n] := Nat.ModEq.pow k h"
  have hp : a ^ k ≡ b ^ k [MOD n] := Nat.ModEq.pow k h
  Hint "Now multiply both sides of `hp` by `c` on the left. Type: exact Nat.ModEq.mul_left c hp"
  exact Nat.ModEq.mul_left c hp

Conclusion
"
Congruences behave exactly like equalities under the operations that
matter for RSA: raise to a power, multiply by a constant, and the
congruence survives every step. This is the toolkit the capstone assembles
into a full correctness proof.

**APOS stage:** Process — combining two general congruence-preserving laws
in sequence.
"

NewTheorem Nat.ModEq.pow Nat.ModEq.mul_left
