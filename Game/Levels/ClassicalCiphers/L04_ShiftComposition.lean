import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Common
import Mathlib.Tactic.Ring

World "ClassicalCiphers"
Level 4

Title "Shifts as Objects: Composing Keys"

Introduction
"
## A Shift Is a Thing, Not Just a Step

So far a 'shift' has only appeared as something you *do*: an action performed
on a letter. But a shift `k : ZMod 26` is also a mathematical **object** in
its own right — an element of a commutative group that can itself be added,
combined, and reasoned about independently of any particular letter it acts
on.

If you ever apply two independent shifts to
the same position, one after another, does the order matter?

### Your Task

Prove that applying shift `k1` then `k2` gives the same result as applying
`k2` then `k1`.

### Strategy

Again pure ring arithmetic — commutativity and associativity of addition in
`ZMod 26`.
"

Statement (m k1 k2 : ZMod 26) : (m + k1) + k2 = (m + k2) + k1 := by
  Hint "Rearranging sums is exactly what `ring` normalizes. Type: ring"
  ring

Conclusion
"
Treating 'the shift' as an object you can commute and combine — rather than
just a step you perform — is what lets us later reason about *keys* and
*exponents* as first-class algebraic objects, which is exactly what modular
arithmetic and Diffie–Hellman need.

**APOS stage:** Object — a shift treated as a value you combine, not a step
you merely execute.
"
