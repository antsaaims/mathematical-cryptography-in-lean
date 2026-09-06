import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common
import Mathlib.Tactic.Ring

World "ClassicalCiphers"
Level 3

Title "The General Encrypt-Decrypt Law"

Introduction
"
## From Examples to a Law

Checking `7 + 3 - 3 = 7` and `10 - 3 + 3 = 10` one number at a time would take
forever if we wanted to be sure the Caesar cipher *never* loses information.
Instead, we generalize: decrypting an encryption returns the original message
for **every** plaintext `m` and **every** shift `k` at once.

    (m + k) - k = m

This is no longer a single computation to check — it is an algebraic pattern
to *prove*, once and for all.

### Your Task

Prove the general roundtrip law for arbitrary `m k : ZMod 26`.

### Strategy

`ZMod 26` is a commutative ring, and this identity is pure ring arithmetic
(add then subtract the same thing). The `ring` tactic (from the Tutorial
World) closes it directly — no case-by-case checking needed.
"

Statement (m k : ZMod 26) : (m + k) - k = m := by
  Hint "This is a ring identity: adding then subtracting k cancels out. Type: ring"
  ring

Conclusion
"
This is the **Process** stage: instead of performing the action of
encrypting-then-decrypting on one letter, you interiorized it into a single
reusable rule that Lean now knows holds for every letter and every key.

**APOS stage:** Process — a general law, proved once for all inputs.
"
