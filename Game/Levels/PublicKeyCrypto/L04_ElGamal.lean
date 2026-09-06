import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "PublicKeyCrypto"
Level 4

Title "ElGamal: The Same Trick, New Names"

Introduction
"
## Diffie–Hellman, Wearing a Disguise

**ElGamal encryption** publishes a group generator `g` and `g ^ a` (Alice's
public key, secret exponent `a`). To encrypt `m` under a random one-time
secret `k`, Bob sends `(g ^ k, m * (g ^ a) ^ k)`. Alice decrypts by
computing `(g ^ k) ^ a` and dividing it out.

For decryption to recover `m`, Alice's computed mask `(g ^ k) ^ a` must
equal Bob's masking factor `(g ^ a) ^ k` — which is exactly the
Diffie–Hellman identity from Modular Arithmetic World, dressed in new
variable names.

### Your Task

Prove `elgamalDecryptMask g a k = elgamalEncryptMask g a k`.

### Strategy

No hints spell out the steps this time — but you've closed a goal of
exactly this shape before.
"

def elgamalEncryptMask {n : ℕ} (g : ZMod n) (a k : ℕ) : ZMod n := (g ^ a) ^ k
def elgamalDecryptMask {n : ℕ} (g : ZMod n) (a k : ℕ) : ZMod n := (g ^ k) ^ a

Statement {n : ℕ} (g : ZMod n) (a k : ℕ) :
    elgamalDecryptMask g a k = elgamalEncryptMask g a k := by
  Hint (hidden := true) "Unfold both definitions to reach plain exponent arithmetic."
  unfold elgamalDecryptMask elgamalEncryptMask
  Hint (hidden := true) "This is the Diffie–Hellman identity from Modular Arithmetic World, under different names."
  rw [← pow_mul, ← pow_mul, mul_comm]

Conclusion
"
Same identity, same two-line proof, completely different cryptographic
story: Diffie–Hellman uses it to let two parties agree on a shared secret;
ElGamal uses it to let a masking factor be computed two different ways by
two different parties, so it cancels out at decryption time.

**APOS stage:** Object — recognizing the same abstract structure underneath
a new cryptographic protocol.
"
