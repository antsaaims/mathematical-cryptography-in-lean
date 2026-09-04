import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common

World "ClassicalCiphers"
Level 2

Title "Decrypting with the Caesar Cipher"

Introduction
"
## Undoing a Shift

If encryption adds the shift `k`, decryption should undo that addition — so
it subtracts `k`:

    m = c - k   (mod 26)

### Your Task

Check the mirror image of the last level: decrypting ciphertext `10` with
shift `3` recovers plaintext `7`.

### Strategy

Same idea as before: this is a concrete computation in `ZMod 26`, so
`decide` settles it.
"

Statement : (10 : ZMod 26) - 3 = 7 := by
  Hint "Another concrete ZMod computation. Type: decide"
  decide

Conclusion
"
Encryption adds a shift, decryption subtracts it. Individually, these are two
one-off checks — in the next level we will see that this always works, for
*any* message and *any* shift, not just these two numbers.
"
