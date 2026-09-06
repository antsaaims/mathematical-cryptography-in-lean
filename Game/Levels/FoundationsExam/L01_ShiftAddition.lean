import Game.Metadata
import Game.Levels.ClassicalCiphers.L07_Capstone
import Mathlib.Tactic.Common

World "FoundationsExam"
Level 1

Title "Exam: Two Shifts Make One Shift"

Introduction
"
## Checkpoint: Classical Ciphers World

No new tools this level — everything you need, you already built in
Classical Ciphers World. Recall `caesarEncrypt k m = m + k`.

### Your Task

Prove that encrypting with key `k1` and then with key `k2` is the same as
encrypting once with the combined key `k1 + k2`.

This wasn't stated anywhere in Classical Ciphers World — you'll need to
decide for yourself which of your existing tools applies.
"

Statement (k1 k2 m : ZMod 26) :
    caesarEncrypt k2 (caesarEncrypt k1 m) = caesarEncrypt (k1 + k2) m := by
  Hint (hidden := true) "Unfold `caesarEncrypt` on both sides to reach ordinary `ZMod 26` arithmetic."
  unfold caesarEncrypt
  Hint (hidden := true) "You've closed goals of exactly this shape before, without naming individual steps."
  ring

Conclusion
"
Two shifts really are just one shift, with keys added. This is why the
Caesar cipher's keyspace never actually grows no matter how many times you
re-encrypt: repeated shifting stays inside the same 26-key system.

One down, one to go — Level 2 checks Perfect Secrecy World the same way.

**APOS stage:** N/A — a retrieval checkpoint, not new teaching content; see
Classical Ciphers World for this fact's own stage.
"
