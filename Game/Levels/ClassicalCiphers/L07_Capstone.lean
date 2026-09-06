import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common
import Mathlib.Tactic.Ring

World "ClassicalCiphers"
Level 7

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
`caesarEncrypt k` for every message and key. Across this world you saw the
same shape of argument survive three increasingly general settings — a
single shift (Caesar), any permutation of the alphabet at all
(Substitution), and a whole sequence of shifts keyed by position
(Vigenère) — and every one of them still comes down to *invertibility*:
some operation and its exact undo.

None of the three resist a determined attacker: Caesar has only 26 keys to
try, general substitution preserves letter frequencies, and a repeating
Vigenère key reintroduces a periodic pattern. Invertibility alone was never
the missing ingredient — modern cryptography needs a keyspace no computer
can exhaustively search *and* an operation that doesn't leak structure the
way addition does.

Next: **Perfect Secrecy World**, where a different kind of shift — XOR,
used only once — closes exactly the gap this Conclusion just named.

**APOS stage:** Schema — Action, Process, and Object stages from this
world, synthesized across three increasingly general ciphers.
"

NewTactic unfold
