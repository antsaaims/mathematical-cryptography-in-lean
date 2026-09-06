import Game.Metadata
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.Tactic.Common

World "PerfectSecrecy"
Level 4

Title "Collisions Are Unavoidable"

Introduction
"
## A Different Kind of Foundation

This world's other levels are about the one-time pad. This one is about a
related but separate piece of the same information-theoretic foundations:
why every hash function *must* have collisions — two different inputs
mapping to the same output — as soon as the input space is bigger than the
output space.

If `f : α → β` and `α` has strictly more elements than `β`, then `f` cannot
possibly be injective: there just aren't enough distinct outputs to give
every input its own. This is the **pigeonhole principle** — a *guarantee*
that a collision exists once you've tried every one of the more-than-`2^n`
possible inputs to an `n`-bit hash function. The **birthday bound** is a
separate, stronger, and genuinely harder probabilistic fact: collisions
become *likely* among far fewer than `2^n` *random* inputs — around `2^(n/2)`
— which this course states as real background but does not formalize; only
the pigeonhole guarantee below is something you'll actually prove.

### Your Task

Given `f : α → β` with `α` strictly bigger than `β`, prove two *different*
inputs exist that `f` sends to the *same* output.

### Strategy

Mathlib already has the pigeonhole principle in exactly this form.
"

Statement {α β : Type} [Fintype α] [Fintype β] [DecidableEq β] (f : α → β)
    (h : Fintype.card β < Fintype.card α) :
    ∃ a1 a2, a1 ≠ a2 ∧ f a1 = f a2 := by
  Hint "This is precisely Mathlib's pigeonhole principle. Type: exact Fintype.exists_ne_map_eq_of_card_lt f h"
  exact Fintype.exists_ne_map_eq_of_card_lt f h

Conclusion
"
No hash function can be collision-free once its input space outgrows its
output space — this isn't a design flaw to fix, it's forced by counting
alone. Real hash functions instead aim for collisions to be merely
*infeasible to find on purpose*, which is a very different (and much
harder) goal than 'don't exist.'

**APOS stage:** Object — a counting argument treated as a single reusable
fact, not a per-case computation.
"

NewTheorem Fintype.exists_ne_map_eq_of_card_lt
