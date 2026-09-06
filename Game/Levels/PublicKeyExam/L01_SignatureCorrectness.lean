import Game.Metadata
import Game.Levels.PublicKeyCrypto.L05_Capstone
import Mathlib.Tactic.Ring

World "PublicKeyExam"
Level 1

Title "Exam: RSA Signature Correctness"

Introduction
"
## Checkpoint: Public-Key Cryptography World

The capstone promised that swapping `e` and `d` turns RSA decryption
correctness into RSA *signature* correctness: sign with the private
exponent `d`, verify with the public exponent `e`. Prove that promise.

### Your Task

Prove `(m ^ d) ^ e ≡ m [MOD n]`, given the same key relation as before
(now written `d * e`) and `Nat.Coprime m n`.

### Strategy

Nothing here is new — only the order the two exponents appear in.
"

Statement (n e d k m : ℕ) (hcop : Nat.Coprime m n) (hkey : d * e = 1 + k * n.totient) :
    (m ^ d) ^ e ≡ m [MOD n] := by
  Hint (hidden := true) "This is the capstone's entire proof, with `e` and `d` trading places throughout."
  rw [← pow_mul, hkey]
  have hstep : m ^ (1 + k * n.totient) = m * (m ^ n.totient) ^ k := by ring
  rw [hstep]
  have heuler : m ^ n.totient ≡ 1 [MOD n] := Nat.ModEq.pow_totient hcop
  have hpow : (m ^ n.totient) ^ k ≡ 1 ^ k [MOD n] := Nat.ModEq.pow k heuler
  rw [one_pow] at hpow
  have hfinal : m * (m ^ n.totient) ^ k ≡ m * 1 [MOD n] := Nat.ModEq.mul_left m hpow
  rw [mul_one] at hfinal
  exact hfinal

Conclusion
"
Signing and verifying are the same correctness fact as encrypting and
decrypting, because `d * e = e * d` — multiplication doesn't care which
exponent you call 'public' and which you call 'private.'

**Checkpoint cleared.**

**APOS stage:** N/A — a retrieval checkpoint reusing the capstone's own
proof, not new teaching content.
"
