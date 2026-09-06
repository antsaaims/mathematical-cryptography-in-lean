import Game.Metadata
import Game.Levels.ModularArithmetic.L06_Euler
import Mathlib.Data.Nat.Totient
import Mathlib.Tactic.Common

World "NumberTheoryExam"
Level 1

Title "Exam: Fermat as a Special Case of Euler"

Introduction
"
## Checkpoint: Modular Arithmetic World

Modular Arithmetic World proved Fermat's Little Theorem and Euler's Theorem
as two separate facts. They aren't separate — Fermat's theorem is *exactly*
what Euler's theorem says when the modulus happens to be prime. Nothing new
is being taught here: you're asked to see the connection yourself.

### Your Task

Given a prime `p` and `a` coprime to `p`, prove `a ^ (p - 1) ≡ 1 [MOD p]` —
starting from Euler's Theorem, not by citing Fermat's theorem directly.

### Strategy

You'll need `Nat.totient_prime`, which says `p.totient = p - 1` for primes —
this was never mentioned before, but it's exactly the missing piece.
"

Statement (p a : ℕ) (hp : p.Prime) (h : Nat.Coprime a p) :
    a ^ (p - 1) ≡ 1 [MOD p] := by
  Hint (hidden := true) "Start from Euler's Theorem for this modulus, as a named intermediate fact."
  have he : a ^ p.totient ≡ 1 [MOD p] := Nat.ModEq.pow_totient h
  Hint (hidden := true) "Euler's theorem currently mentions `p.totient`, not `p - 1` — bridge the two with `Nat.totient_prime`."
  rw [Nat.totient_prime hp] at he
  exact he

Conclusion
"
Fermat's Little Theorem was never really a second theorem — it's Euler's
Theorem, specialized to a prime modulus via `φ(p) = p - 1`. Seeing a
'special case' relationship like this is exactly the kind of connection a
research paper will assume you can spot without it being spelled out.

**Checkpoint cleared.**

**APOS stage:** N/A — a retrieval checkpoint synthesizing two prior
levels' facts, not new teaching content.
"

NewTheorem Nat.totient_prime
