import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "ClassicalCiphers"
Level 6

Title "The Vigenère Cipher: A Shift Per Letter"

Introduction
"
## A Different Shift for Every Position

The **Vigenère cipher** fixes the biggest weakness of a single Caesar shift:
instead of one key `k`, it uses a whole *keyword*, repeated to match the
length of the message, and applies a different Caesar shift at each
position.

If the message is `n` letters long, model the (already-repeated) key as a
function `key : Fin n → ZMod 26` giving one shift per position, and encrypt
position-by-position exactly like Caesar:

    vigenereEncrypt key m i = m i + key i
    vigenereDecrypt key c i = c i - key i

### Your Task

Prove that decrypting an encrypted message recovers it, at *every* position
`i` simultaneously — i.e. the two functions `vigenereDecrypt key ∘ vigenereEncrypt key`
and `m` are equal.

### Strategy

Two functions on `Fin n` are equal exactly when they agree at every input
(`funext`). After that, each position is the same one-position roundtrip
identity you already proved for Caesar back in Level 3.
"

def vigenereEncrypt {n : ℕ} (key m : Fin n → ZMod 26) : Fin n → ZMod 26 :=
  fun i => m i + key i

def vigenereDecrypt {n : ℕ} (key c : Fin n → ZMod 26) : Fin n → ZMod 26 :=
  fun i => c i - key i

Statement {n : ℕ} (key m : Fin n → ZMod 26) :
    vigenereDecrypt key (vigenereEncrypt key m) = m := by
  Hint "Two functions are equal when they agree everywhere. Type: funext i"
  funext i
  Hint "Unfold both definitions to reach the same ring identity as the Caesar roundtrip. Type: unfold vigenereEncrypt vigenereDecrypt"
  unfold vigenereEncrypt vigenereDecrypt
  Hint "Finish exactly as you did for Caesar. Type: ring"
  ring

Conclusion
"
Every position of a Vigenère-encrypted message is undone independently, by
the matching position of the key — `n` Caesar roundtrips running side by
side. This is why, historically, Vigenère resisted simple frequency analysis
for so long: a single plaintext letter no longer maps to a single ciphertext
symbol, since the shift changes with position.

It is still not unconditionally secure: a *repeating* key of length shorter
than the message reintroduces a periodic pattern an attacker can find
(the Kasiski examination). The next world's One-Time-Pad level shows what
it takes to close that gap for good.

**APOS stage:** Object — a keyed family of Caesar shifts, packaged as a
single indexed function rather than 26 separate cases.
"

NewTactic funext
