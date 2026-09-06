import Game.Metadata
import Game.Levels.PerfectSecrecy.L01_XorSelfInverse
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "PerfectSecrecy"
Level 2

Title "The One-Time Pad Decrypts Itself"

Introduction
"
## One Function, Two Jobs

The **one-time pad (OTP)** encrypts an `n`-bit message `m` with an `n`-bit
key `k` (as long as the message, used only once — hence the name) by XOR-ing
them position by position:

    otpEncrypt k m i = m i + k i

Unlike Caesar (which needed a separate `-k` to decrypt), OTP has a striking
property: encrypting *twice* with the same key gets you back to where you
started. Decryption isn't a different operation — it's the same one.

### Your Task

Prove that encrypting an OTP-encrypted message a second time, with the same
key, recovers the original message.

### Strategy

Reduce to a single position with `funext`, unfold the definition, then
package Level 1's fact as a named intermediate step with `have` before
using it to finish.
"

def otpEncrypt {n : ℕ} (k m : Fin n → ZMod 2) : Fin n → ZMod 2 :=
  fun i => m i + k i

Statement {n : ℕ} (k m : Fin n → ZMod 2) :
    otpEncrypt k (otpEncrypt k m) = m := by
  Hint "Two functions are equal exactly when they agree everywhere. Type: funext i"
  funext i
  Hint "Unfold the definition to expose the underlying bit arithmetic. Type: unfold otpEncrypt"
  unfold otpEncrypt
  Hint "Package Level 1's fact, applied to this key bit, as a named intermediate step. Type: have hk : k i + k i = 0 := xor_self_zero (k i)"
  have hk : k i + k i = 0 := xor_self_zero (k i)
  Hint "Regroup the sum so the two key copies are adjacent, then use `hk` to cancel them. Type: rw [add_assoc, hk, add_zero]"
  rw [add_assoc, hk, add_zero]

Conclusion
"
`otpEncrypt k` is its own inverse: applying it twice is the identity. This
is `xor_self_zero` lifted, bit by bit, from a single bit to an entire
message — the same 'add it again to undo it' idea, just repeated `n` times
in parallel.

**APOS stage:** Process — generalizing a single-position law into a
statement about a whole indexed family at once.
"

NewTactic «have»
