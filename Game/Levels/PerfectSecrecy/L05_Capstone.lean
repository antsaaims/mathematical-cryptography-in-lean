import Game.Metadata
import Game.Levels.PerfectSecrecy.L01_XorSelfInverse
import Game.Levels.PerfectSecrecy.L02_OneTimePad
import Mathlib.Tactic.Common

World "PerfectSecrecy"
Level 5

Title "Capstone: Why You Never Reuse a One-Time Pad"

Introduction
"
## The Same Fact, Cutting Both Ways

Level 1's fact — a key cancels with itself — is exactly what makes the
one-time pad unconditionally secure (Levels 2–3, given a uniformly random
key, per Level 3's hedge). It is *also* exactly what destroys that
security the moment a key is reused.

Suppose the same key `k` encrypts two different messages, `m1` and `m2`.
An eavesdropper who intercepts both ciphertexts can add them together:

    otpEncrypt k m1 + otpEncrypt k m2 = (m1 + k) + (m2 + k)

### Your Task

Prove that this sum eliminates the key entirely, leaking `m1 + m2` — the
bitwise XOR of the two plaintexts — directly to anyone who was merely
listening, with no key at all.

### Strategy

Reduce to one position with `funext`, unfold, then reuse the `have` +
rewrite pattern from Level 2 — this time regrouping so *both* copies of the
key sit next to each other.
"

Statement {n : ℕ} (k m1 m2 : Fin n → ZMod 2) :
    (fun i => otpEncrypt k m1 i + otpEncrypt k m2 i) = (fun i => m1 i + m2 i) := by
  Hint "Two functions are equal exactly when they agree everywhere. Type: funext i"
  funext i
  Hint "Unfold both encryptions to expose the underlying bit arithmetic. Type: unfold otpEncrypt"
  unfold otpEncrypt
  Hint "Regroup the sum so both copies of the key are adjacent. Type: have step : m1 i + k i + (m2 i + k i) = m1 i + m2 i + (k i + k i) := by ring"
  have step : m1 i + k i + (m2 i + k i) = m1 i + m2 i + (k i + k i) := by ring
  Hint "Rewrite using `step`, then cancel the two key copies exactly as in Level 1. Type: rw [step, xor_self_zero, add_zero]"
  rw [step, xor_self_zero, add_zero]

Conclusion
"
Congratulations — you've completed the Perfect Secrecy World!

You proved that the one-time pad is unconditionally secure when a key is
chosen uniformly at random and used *once* (Levels 1–3), and you just
proved exactly why the name has
'one-time' in it: reuse the key for a second message, and the key cancels
out of the sum of the two ciphertexts, leaking the XOR of the two
plaintexts to anyone listening — no computational assumption, no
brute-force search, just algebra. Real-world key-reuse breaks (from the
Venona intercepts to reused WEP keystreams) all follow exactly this
identity.

Notice that everything in this world — the security *and* the attack —
reduced to statements Lean could check completely over a 2-element ring.
That's the double edge of a tiny keyspace: perfectly easy to reason about,
which is also exactly why a key must never be reused or guessed.

Next: a short **Foundations Exam** checkpoint reusing Classical Ciphers
World and this world together, then **Modular Arithmetic World**, where
the ring gets bigger than 2 elements, and 'reasoning about every case by
hand' stops being an option — which is precisely why cryptography needs
the algebra, not just the count.

**APOS stage:** Schema — the same Level 1 fact, synthesized into both the
security argument (Level 2–3) and its exact failure mode (this level).
"
