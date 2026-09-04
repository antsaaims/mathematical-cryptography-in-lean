import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "ClassicalCiphers"
Level 5

Title "Capstone: The Caesar Cipher Is a Bijection"

Introduction
"
## Synthesis: Encryption You Can Always Undo

Let's package everything from this world into a single cryptographic
guarantee. Define the encryption and decryption functions explicitly:

    caesarEncrypt k m = m + k
    caesarDecrypt k c  = c - k

The **Schema** stage means combining the *object* (a shift `k`), the
*process* (the general roundtrip law), and the *actions* (concrete
encrypt/decrypt) into one coherent system: a cipher is only usable if
decryption always undoes encryption, for every message and every key. That
is exactly what makes `caesarDecrypt k` and `caesarEncrypt k` inverse
functions of each other — i.e. the cipher is a **bijection** on `ZMod 26`.

### Your Task

Prove that decrypting an encrypted message with the same key returns the
original message.

### Strategy

Unfold both definitions to expose the underlying ring identity from Level 3,
then close with `ring`.
"

def caesarEncrypt (k m : ZMod 26) : ZMod 26 := m + k
def caesarDecrypt (k c : ZMod 26) : ZMod 26 := c - k

Statement (k m : ZMod 26) : caesarDecrypt k (caesarEncrypt k m) = m := by
  Hint "First unfold both definitions to reveal the ring identity underneath. Type: unfold caesarEncrypt caesarDecrypt"
  unfold caesarEncrypt caesarDecrypt
  Hint "Now this is the same cancellation law you already proved. Type: ring"
  ring

Conclusion
"
Congratulations — you've completed the Classical Ciphers World!

You proved that the Caesar cipher is invertible: `caesarDecrypt k` undoes
`caesarEncrypt k` for every message and key. But notice the weakness: there
are only 26 possible keys, so this cipher can be broken by simply trying all
of them.

Modern cryptography needs a keyspace no computer can exhaustively search.
Next, in **Modular Arithmetic World**, we move from *adding* a shift to
*exponentiating* modulo a large number — the operation underlying
Diffie–Hellman and RSA.
"

NewTactic unfold
