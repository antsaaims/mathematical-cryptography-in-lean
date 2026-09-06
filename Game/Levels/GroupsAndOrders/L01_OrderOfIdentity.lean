import Game.Metadata
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Tactic.Common

World "GroupsAndOrders"
Level 1

Title "The Order of an Element"

Introduction
"
## How Long Until You Return to Start?

The **order** of an element `g` in a group `G`, written `orderOf g`, is the
smallest positive `n` with `g ^ n = 1` — how many times you must repeat `g`
before you cycle back to the identity. `Diffie–Hellman` and `RSA` both live
or die by the order of the elements they use.

### Your Task

Prove the simplest case: the identity element has order `1` — you're
already 'back to start' after a single step, since `1 ^ 1 = 1` trivially.

### Strategy

Mathlib already has this exact fact.
"

Statement {G : Type} [Group G] : orderOf (1 : G) = 1 := by
  Hint "This is Mathlib's own statement of the fact. Type: exact orderOf_one"
  exact orderOf_one

Conclusion
"
The identity is the one element that returns to itself immediately. Every
other element's order says something genuinely informative about the
group's structure — which is what the rest of this world explores.

**APOS stage:** Action — a single concrete fact about a specific element.
"

NewDefinition orderOf
NewTheorem orderOf_one
