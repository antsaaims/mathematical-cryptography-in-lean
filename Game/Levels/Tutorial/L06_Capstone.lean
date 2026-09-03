import Game.Metadata
import Mathlib.Algebra.Group.Basic
import Mathlib.Tactic.Common

World "Tutorial"
Level 6

Title "Capstone: Combining Tactics"

Introduction
"
## Capstone Level

In this capstone, you combine everything you have learned: `rw`, `exact`, `apply`,
`simp`, and `ring`.

### Cryptographic Motivation

In the **Diffie-Hellman key exchange**, two parties agree on a shared secret:

    g^(ab) = g^(ba)

This equality holds because exponentiation in a commutative monoid satisfies
g^(a*b) = g^(b*a) when a, b are natural numbers. Proving this algebraically involves:

1. Rewriting with the commutativity of multiplication.
2. Simplifying the exponents.

### Your Task

Given a commutative monoid `M`, an element `g`, natural numbers `a b`, and a
hypothesis `h : a * b = b * a`, prove that `g^(a*b) = g^(b*a)`.

### Strategy

1. Rewrite `a * b` to `b * a` using `h`.
2. The goal becomes trivially true after the rewrite.
"

Statement {M : Type} [CommMonoid M] (g : M) (a b : ℕ) (h : a * b = b * a) :
    g^(a*b) = g^(b*a) := by
  Hint "Rewrite `a * b` to `b * a` using hypothesis `h`. Type: rw [h]"
  rw [h]

Conclusion
"
Congratulations! You have completed the Tutorial World.

You now know the five core tactics (`rw`, `exact`, `apply`, `simp`, `ring`) that
form the backbone of every Lean proof. You also saw how polynomial identities
underpin cryptographic protocols like Diffie-Hellman.

Next up: **Matrix Algebra World**, where we formalize matrices, determinants, and
rank — the building blocks of the UOV and MinRank cryptographic schemes.
"

NewTactic rw exact apply simp ring
