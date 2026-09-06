import Game.Metadata
import Game.Levels.ModularArithmetic.L06_Euler
import Mathlib.Tactic.Common
import Mathlib.Tactic.Ring

World "PublicKeyCrypto"
Level 5

Title "Capstone: RSA Correctness"

Introduction
"
## Putting the Whole Machine Together

Encrypt: `c = m ^ e (mod n)`. Decrypt: `m' = c ^ d (mod n)`. RSA is correct
exactly when `m' = m` — i.e. `(m ^ e) ^ d ≡ m (mod n)` — for every message
`m` coprime to `n`, given the key relation `e * d = 1 + k * φ(n)`.

Every piece is now on the table: Level 3's exponent split, Modular
Arithmetic World's Euler's Theorem, and this world's Level 2 toolkit for
carrying a congruence through powers and products.

### Your Task

Prove RSA's decryption recovers the original message:
`(m ^ e) ^ d ≡ m [MOD n]`, given `Nat.Coprime m n` and the key relation
`e * d = 1 + k * n.totient`.

### Strategy

Combine `(m^e)^d = m^(e*d)` with the key relation to reach Level 3's
exponent split, apply Euler's Theorem, then carry it through with Level 2's
toolkit.
"

Statement (n e d k m : ℕ) (hcop : Nat.Coprime m n) (hkey : e * d = 1 + k * n.totient) :
    (m ^ e) ^ d ≡ m [MOD n] := by
  Hint "Combine the two exponents, then substitute the key relation. Type: rw [← pow_mul, hkey]"
  rw [← pow_mul, hkey]
  Hint "Split off the lone `m`, exactly as in Level 3. Type: have hstep : m ^ (1 + k * n.totient) = m * (m ^ n.totient) ^ k := by ring"
  have hstep : m ^ (1 + k * n.totient) = m * (m ^ n.totient) ^ k := by ring
  rw [hstep]
  Hint "Euler's Theorem: the repeated factor is congruent to 1. Type: have heuler : m ^ n.totient ≡ 1 [MOD n] := Nat.ModEq.pow_totient hcop"
  have heuler : m ^ n.totient ≡ 1 [MOD n] := Nat.ModEq.pow_totient hcop
  Hint "Raise `heuler` to the `k`-th power, exactly as in Level 2. Type: have hpow : (m ^ n.totient) ^ k ≡ 1 ^ k [MOD n] := Nat.ModEq.pow k heuler"
  have hpow : (m ^ n.totient) ^ k ≡ 1 ^ k [MOD n] := Nat.ModEq.pow k heuler
  Hint "Simplify `1 ^ k` to `1`. Type: rw [one_pow] at hpow"
  rw [one_pow] at hpow
  Hint "Multiply `hpow` by `m` on the left, as in Level 2. Type: have hfinal : m * (m ^ n.totient) ^ k ≡ m * 1 [MOD n] := Nat.ModEq.mul_left m hpow"
  have hfinal : m * (m ^ n.totient) ^ k ≡ m * 1 [MOD n] := Nat.ModEq.mul_left m hpow
  Hint "Simplify `m * 1` to `m` inside `hfinal`, then it's exactly the goal. Type: rw [mul_one] at hfinal"
  rw [mul_one] at hfinal
  Hint "Finish with `hfinal`. Type: exact hfinal"
  exact hfinal

Conclusion
"
Congratulations — you've completed the Public-Key Cryptography World!

You proved RSA correct: decryption really does recover the original
message, for a real (if tiny) reason — Euler's Theorem, the same fact you
proved a full world ago, now doing the actual work of cancelling the
`k * φ(n)` part of the exponent down to a single `m`.

Read this exact proof right-to-left with `e` and `d` swapped, and you have
RSA **signatures** for free: sign with the private exponent `d`, verify
with the public exponent `e` — `e * d = d * e`, so the same identity
proves signature verification is correct too. This is *textbook* RSA
signing, correct as far as it goes; real deployments never sign a raw
message this way, because the identity you just proved is also exactly why
naive RSA signatures are forgeable (an attacker can multiply signatures
together the same way ciphertexts multiply in Modular Arithmetic World's
homomorphism level). Real systems hash and pad the message first (schemes
like PKCS#1 or PSS) precisely to break that multiplicative structure — a
security fix this course doesn't formalize, layered on top of the
correctness fact you just did.

Next: a short **Public-Key Exam** checkpoint, after which you're free to
continue to **Secret Sharing World** or **Matrix Algebra World** — both
independent tracks you may already have started.

**APOS stage:** Schema — Euler's Theorem, the exponent-split identity, and
the congruence toolkit, synthesized into one complete correctness proof.
"
