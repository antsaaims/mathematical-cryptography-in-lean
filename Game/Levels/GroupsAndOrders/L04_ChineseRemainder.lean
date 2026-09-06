import Game.Metadata
import Mathlib.Data.Nat.ChineseRemainder
import Mathlib.Tactic.Common

World "GroupsAndOrders"
Level 4

Title "The Chinese Remainder Theorem"

Introduction
"
## One Modulus, Split in Two

RSA's modulus `n = p * q` is a product of two distinct primes. The
**Chinese Remainder Theorem (CRT)** says that working modulo `n` is
exactly the same as working modulo `p` and modulo `q` *simultaneously* —
for any target remainders `a` (mod `p`) and `b` (mod `q`), there's a single
number that hits both at once.

Mathlib packages this as `Nat.chineseRemainder`: given a proof that `n` and
`m` are coprime, and targets `a`, `b`, it hands you a number together with
proofs that it satisfies both congruences.

### Your Task

Given coprime `n`, `m` and targets `a`, `b`, extract the proof that
Mathlib's CRT witness really does satisfy the first congruence,
`≡ a [MOD n]`.

### Strategy

`Nat.chineseRemainder co a b` is a bundled value-with-proof; `.2.1`
extracts the first congruence proof.
"

Statement (n m a b : ℕ) (co : n.Coprime m) :
    (Nat.chineseRemainder co a b : ℕ) ≡ a [MOD n] := by
  Hint "The witness carries its own two congruence proofs bundled with it — take the first one. Type: exact (Nat.chineseRemainder co a b).2.1"
  exact (Nat.chineseRemainder co a b).2.1

Conclusion
"
The Chinese Remainder Theorem's witness isn't just asserted to exist — it
comes bundled together with a checkable certificate of *why* it works. This
is what lets RSA implementations do all their heavy exponentiation
separately, modulo the (much smaller) `p` and `q`, and combine the results
at the end via CRT — a major real-world speedup over working modulo `n`
directly.

**APOS stage:** Object — treating 'the simultaneous solution' as a single
structured object you can extract facts from, not a search procedure.
"

NewDefinition Nat.chineseRemainder
