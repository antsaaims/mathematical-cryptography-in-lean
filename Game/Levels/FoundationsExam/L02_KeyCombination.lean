import Game.Metadata
import Game.Levels.PerfectSecrecy.L02_OneTimePad
import Mathlib.Tactic.Common

World "FoundationsExam"
Level 2

Title "Exam: Combined One-Time-Pad Keys"

Introduction
"
## Checkpoint: Perfect Secrecy World

Recall `otpEncrypt k m i = m i + k i`. Like Level 1's Caesar fact, this
level asks you to prove a combination law that was never stated for you —
only demonstrated, once, in a different shape (Level 1's Caesar shifts).

### Your Task

Prove that OTP-encrypting with key `k1` and then key `k2` is the same as
OTP-encrypting once with the position-by-position combined key
`fun i => k1 i + k2 i`.

### Strategy

No hidden hints this time spell out every step — but the overall shape of
this proof should feel familiar from the rest of this world.
"

Statement {n : ℕ} (k1 k2 m : Fin n → ZMod 2) :
    otpEncrypt k2 (otpEncrypt k1 m) = otpEncrypt (fun i => k1 i + k2 i) m := by
  Hint (hidden := true) "Two functions on `Fin n` are equal exactly when they agree everywhere."
  funext i
  Hint (hidden := true) "Unfold every occurrence of `otpEncrypt` to reach plain `ZMod 2` arithmetic."
  unfold otpEncrypt
  Hint (hidden := true) "This is a rearrangement in a commutative ring — no cancellation fact is even needed here."
  ring

Conclusion
"
Combining one-time-pad keys is just adding them, bit by bit — the exact
counterpart of Level 1's Caesar fact, in the ring `ZMod 2` instead of
`ZMod 26`. Notice this one needed no XOR-cancellation trick at all: it's
true in *any* commutative ring, which is exactly why `ring` alone closes it.

**Foundations checkpoint complete.** Modular Arithmetic World is next —
where the ring stops being small enough to reason about case-by-case.

**APOS stage:** N/A — a retrieval checkpoint, not new teaching content; see
Perfect Secrecy World for this fact's own stage.
"
