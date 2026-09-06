import Game.Metadata
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Tactic.Common

World "GroupsAndOrders"
Level 5

Title "Capstone: Generators and Group Size"

Introduction
"
## Setting Up Diffie–Hellman's Public Group

A **generator** of a finite group `G` is an element `g` whose order equals
the size of the whole group — repeating `g` visits every single element of
`G` before returning to `1`. Diffie–Hellman and ElGamal both start by
publishing such a `g`, together with the group's order, as shared public
parameters.

### Your Task

Given a generator `g` (i.e. `orderOf g = Fintype.card G`), prove that
raising `g` to the power of the *group's size* returns `1`.

### Strategy

Substitute the generator hypothesis into Level 2's defining property of
order.
"

Statement {G : Type} [Group G] [Fintype G] (g : G) (h : orderOf g = Fintype.card G) :
    g ^ Fintype.card G = 1 := by
  Hint "Rewrite the goal using the generator hypothesis, backwards, to reach `orderOf g`. Type: rw [← h]"
  rw [← h]
  Hint "This is exactly Level 2's defining property. Type: exact pow_orderOf_eq_one g"
  exact pow_orderOf_eq_one g

Conclusion
"
Congratulations — you've completed the Groups and Orders World!

You now have the exact three facts public-key cryptography's group-based
schemes are built from: every element's order divides the group's size
(Level 3, which is *why* prime-order groups block certain attacks), the
Chinese Remainder Theorem (Level 4 — real RSA implementations use it to do
their exponentiation modulo the much-smaller `p` and `q` separately, a
major speedup this course doesn't formalize but that follows from exactly
the existence fact you extracted from Mathlib's bundled witness), and —
just now — that a published generator's order equals the group's
published size, the starting assumption Diffie–Hellman and ElGamal both
build on.

Next: a short **Number Theory Exam** checkpoint spanning this world and
Modular Arithmetic World, after which the course splits into three
independent tracks you can take in any order: **Public-Key Cryptography
World** (which reuses Modular Arithmetic World's Euler's Theorem and this
world's group vocabulary to prove RSA and ElGamal correct), **Secret
Sharing World**, and **Matrix Algebra World** (leading to UOV and MinRank).

**APOS stage:** Schema — combining the group-size relationship (Level 3)
and order's defining property (Level 2) into the exact setup Diffie–Hellman
publishes.
"
