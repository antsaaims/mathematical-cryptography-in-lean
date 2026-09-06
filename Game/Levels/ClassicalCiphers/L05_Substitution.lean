import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Logic.Equiv.Basic
import Mathlib.Tactic.Common

World "ClassicalCiphers"
Level 5

Title "Substitution Ciphers: Any Permutation Works"

Introduction
"
## Beyond a Single Shift

The Caesar cipher only ever shifts every letter by the *same* amount `k`.
A general **substitution cipher** scrambles the alphabet by *any* rule at
all — as long as that rule never sends two different letters to the same
place, so decryption is possible.

'Never sends two different letters to the same place, and hits every
letter' is exactly what Mathlib calls a **permutation**: `Equiv.Perm (Fin 26)`
is the type of bijections from the alphabet to itself, bundled together
with their own inverse. A permutation doesn't need the ring structure
(addition, multiplication) that `ZMod 26` carries — just 26 distinguishable
letters — so this level uses the plainer `Fin 26` instead; they're the
same 26 elements underneath, viewed with only as much structure as the
task actually needs.

### Your Task

Given any substitution rule `σ : Equiv.Perm (Fin 26)` (not just a shift!)
and its inverse `σ.symm`, prove that decrypting an encrypted message
recovers the original: `σ.symm (σ m) = m`.

### Strategy

This is exactly what it means for `σ.symm` to be a two-sided inverse of `σ`
— Mathlib has a lemma for precisely this.
"

Statement (sigma : Equiv.Perm (Fin 26)) (m : Fin 26) :
    sigma.symm (sigma m) = m := by
  Hint "This is the defining property of an inverse permutation. Type: exact Equiv.symm_apply_apply sigma m"
  exact Equiv.symm_apply_apply sigma m

Conclusion
"
Caesar's shift-by-`k` is one particular permutation of the alphabet out of
`26!` possible substitution ciphers — an astronomically larger keyspace.
But size alone doesn't make a cipher secure: a substitution cipher preserves
letter *frequencies* (every 'e' in the plaintext becomes the same symbol in
the ciphertext), which is exactly how these ciphers are broken in practice,
`26!` keys notwithstanding.

**APOS stage:** Object — the whole cipher is now a single bundled object
(a permutation, with its inverse built in), not a formula you apply by hand.
"

NewDefinition Equiv.Perm
