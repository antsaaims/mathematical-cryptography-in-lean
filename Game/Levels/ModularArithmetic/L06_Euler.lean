import Game.Metadata
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Data.Nat.Totient
import Mathlib.Tactic.Common

World "ModularArithmetic"
Level 6

Title "Euler's Theorem"

Introduction
"
## Beyond Prime Moduli

Fermat's Little Theorem needed a *prime* modulus. Real cryptosystems like
RSA use a modulus `n = p * q` — a product of two primes, not prime itself.
**Euler's Theorem** is exactly Fermat's theorem generalized to work for
*any* modulus `n`, replacing 'nonzero' with the right general condition
('coprime to `n`') and replacing the exponent `p - 1` with **Euler's
totient** `n.totient` (written `φ(n)`): the count of numbers below `n` that
share no common factor with it.

    Fermat:  a coprime to p (prime)   ⟹  a ^ (p - 1)      ≡ 1 (mod p)
    Euler:   a coprime to n (any n)   ⟹  a ^ (totient n)  ≡ 1 (mod n)

When `n = p` is prime, `φ(p) = p - 1` and Euler's theorem *is* Fermat's.

### Your Task

Prove Euler's Theorem: if `x` and `n` are coprime, then
`x ^ n.totient ≡ 1 [MOD n]`.

### Strategy

Mathlib already has this exact theorem too — it even calls it by name.
"

Statement (x n : ℕ) (h : Nat.Coprime x n) : x ^ n.totient ≡ 1 [MOD n] := by
  Hint "Mathlib literally calls this 'the Fermat-Euler totient theorem.' Type: exact Nat.ModEq.pow_totient h"
  exact Nat.ModEq.pow_totient h

Conclusion
"
This is the single theorem that makes RSA correct. In two worlds, you'll
choose `n = p * q` for distinct primes `p`, `q`, pick encryption/decryption
exponents `e`, `d` with `e * d ≡ 1 (mod φ(n))`, and use exactly this fact to
show that decrypting an encrypted message returns it unchanged.

**APOS stage:** Object — the general-modulus black-box tool that Fermat's
theorem (Level 5) turns out to be one special case of.
"

NewTheorem Nat.ModEq.pow_totient
