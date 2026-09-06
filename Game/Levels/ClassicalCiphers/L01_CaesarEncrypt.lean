import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "ClassicalCiphers"
Level 1

Title "Encrypting with the Caesar Cipher"

Introduction
"
## Letters as Numbers

To do cryptography with Lean, we first need to turn letters into numbers. Map
`A, B, ..., Z` to `0, 1, ..., 25`, and work modulo 26 so that shifting past `Z`
wraps back around to `A`. In Lean, the type of integers modulo `26` is
**`ZMod 26`**.

### The Caesar Cipher

The **Caesar cipher** encrypts a letter `m` (plaintext) with a secret shift
`k` by computing:

    c = m + k   (mod 26)

For example, with shift `k = 3`, the letter `H` (which is `7`) encrypts to
`K` (which is `10`), since `7 + 3 = 10`.

### Your Task

Check this concrete example: encrypting `7` with shift `3` gives `10`.

### Strategy

`ZMod 26` is a finite type with decidable equality, so Lean can simply
*compute* both sides and compare them. The `decide` tactic does exactly this.
"

Statement : (7 : ZMod 26) + 3 = 10 := by
  Hint "ZMod 26 arithmetic on concrete numbers can be checked by direct computation. Type: decide"
  decide

Conclusion
"
You just performed your first Caesar-cipher encryption in Lean. Every step of
a cipher, no matter how classical, is ultimately just arithmetic — and
arithmetic is exactly what a proof assistant can check for you.

**APOS stage:** Action — a single, concrete, decidable computation.
"

NewTactic decide
NewDefinition ZMod
