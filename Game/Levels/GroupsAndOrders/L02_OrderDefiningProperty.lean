import Game.Metadata
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Tactic.Common

World "GroupsAndOrders"
Level 2

Title "The Defining Property of Order"

Introduction
"
## Raising g to Its Own Order

If `orderOf g` really is 'the number of steps to return to the identity,'
then raising `g` to exactly that power should land you back at `1`. This is
true by definition when `orderOf g` is finite — and Mathlib's `orderOf`
is set up so this always holds, even when it isn't obviously finite.

### Your Task

Prove that `g ^ orderOf g = 1` for any element `g` of a group `G`.

### Strategy

This is, essentially, what `orderOf` was built to satisfy.
"

Statement {G : Type} [Group G] (g : G) : g ^ orderOf g = 1 := by
  Hint "Mathlib's own defining property of `orderOf`. Type: exact pow_orderOf_eq_one g"
  exact pow_orderOf_eq_one g

Conclusion
"
`g ^ orderOf g = 1`, always. Later, when Diffie–Hellman and RSA pick a
generator `g` of a group with a *known* order, this is exactly the fact
that guarantees exponent arithmetic can be done modulo that order — you
never actually need `g` raised to a power larger than `orderOf g`.

**APOS stage:** Process — a general law that holds for *every* element,
not a single case.
"

NewTheorem pow_orderOf_eq_one
