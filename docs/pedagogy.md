# Pedagogy: Active Retrieval and Spaced Practice Map

This file is the living version of the design table used to build this
course. It exists so that adding a new level means adding a row here too —
every tool introduced anywhere in the game should have a teaching level, a
spaced-retrieval reappearance at least one world later, and an appearance
in a cumulative exam. See `Game.lean`'s dependency graph for how the course
branches into independent tracks after the Number Theory Exam.

## Design principle

No engine feature implements "spaced repetition" here — lean4game is a
linear proof game with no flashcard/review-queue mechanism, and the game
must run on the stock community server. Instead:

- **Spaced practice** = a tool reappears, unannounced, in a level in a
  *later world* (never the immediate next level), under a new surface
  story, with the Introduction not re-explaining how it works.
- **Active retrieval** = at least one reappearance is *harder* than the
  teaching level: hints hidden (`Hint (hidden := true)`) rather than
  proactive, and/or the tool must be chosen among several rather than
  named, and/or combined with a second previously-learned tool.

## Coverage table

| # | Concept / tool | Taught in | Spaced retrieval | Active-retrieval / hardened use | Exam appearance(s) |
|---|---|---|---|---|---|
| 1 | `rw` | Tutorial L01 | ModularArithmetic L07 (DH capstone) | PublicKeyCrypto L05 (unnamed) | FoundationsExam, FinalExam |
| 2 | `exact` | Tutorial L02 | throughout | every exam (unnamed) | all exams |
| 3 | `apply` | Tutorial L03 | — | — | — |
| 4 | `simp` | Tutorial L04 | MinRank L02 | — | — |
| 5 | `ring` | Tutorial L05 | ClassicalCiphers L07 (Caesar), SecretSharing L02 (`Polynomial (ZMod 5)`), FinalExam L01 (`AdjoinRoot f`) | SecretSharingExam L01 (hidden hint) | SecretSharingExam, FinalExam |
| 6 | Bijection / invertibility idea | ClassicalCiphers L05 (`Equiv.Perm`) | PerfectSecrecy L01–L03 (XOR, `∃!`-flavored uniqueness), SecretSharing L03 (Lagrange injectivity), UOV L08 (`e.apply_symm_apply`) | FinalExam L03 (contrapositive) | FoundationsExam, FinalExam |
| 7 | Modular inverse | ModularArithmetic L01 | PublicKeyCrypto (RSA key relation) | PublicKeyExam | NumberTheoryExam, PublicKeyExam |
| 8 | `pow_mul` + `mul_comm` (DH engine) | ModularArithmetic L03/L07 | PublicKeyCrypto L04 (ElGamal, renamed defs, hidden hints) | PublicKeyCrypto L04, PublicKeyExam | PublicKeyExam |
| 9 | Ring homomorphism (`mul_pow`) | ModularArithmetic L04 | — | — | — |
| 10 | Fermat's Little Theorem | ModularArithmetic L05 | NumberTheoryExam L01 (derived from Euler instead of cited) | NumberTheoryExam | NumberTheoryExam |
| 11 | Euler's Theorem | ModularArithmetic L06 | PublicKeyCrypto L05 (RSA capstone), PublicKeyExam L01 (swapped exponents) | PublicKeyExam | PublicKeyExam, FinalExam |
| 12 | Order of an element | GroupsAndOrders L01–L02 | NumberTheoryExam L02 (`pow_card_eq_one`, found by analogy) | NumberTheoryExam | NumberTheoryExam |
| 13 | `orderOf_dvd_card` | GroupsAndOrders L03 | — | — | NumberTheoryExam (narrative) |
| 14 | Chinese Remainder Theorem | GroupsAndOrders L04 | — | — | — |
| 15 | `Nat.ModEq` toolkit (`pow`, `mul_left`, `mul`) | PublicKeyCrypto L02 | PublicKeyExam L02 (`.mul`, not `.mul_left`) | PublicKeyExam | PublicKeyExam |
| 16 | Matrix entrywise reasoning | MatrixAlgebra L02 | MinRank (existing) | — | — |
| 17 | `Matrix.rank` | MatrixAlgebra L07 | FinalExam L02 | FinalExam | FinalExam |
| 18 | Invertible ⟺ det unit ⟺ det ≠ 0 | MatrixAlgebra L08, UOV L10 | FinalExam L02–L03 | FinalExam L03 | FinalExam |
| 19 | Pigeonhole | PerfectSecrecy L04 | — | — | FinalExam (narrative) |
| 20 | Lagrange interpolation | SecretSharing L01, L03–L05 | SecretSharingExam L02 (the converse direction), UOV L11 (linearity, `map_add`) | UOV L11 (hardest level in the course: requires both Secret Sharing and UOV World, though its one hint is fully visible and names the exact lemma) | SecretSharingExam |
| 21 | Quadratic map from a bilinear map | UOV L01 | UOV L06/L08 (`QuadraticMap.comp`) | — | — |
| 22 | Quotient rings (`AdjoinRoot`) | UOV L09 | FinalExam L01 (`ring` transfer) | — | FinalExam |

## Auditing this table

Before calling any world "done," check every row has a non-empty spaced
retrieval cell and a non-empty exam column — a blank in either is either an
orphaned tool (fix: add a reappearance) or a deliberate, justified exception
(state why). Rows 4, 9, 13, 14, and 19 (pigeonhole — a single-appearance
supporting fact whose only reappearance is a narrative mention, not a
level) are single-appearance supporting facts
rather than central course tools. Rows 3 (`apply`), 16 (matrix entrywise
reasoning), and 21 (quadratic map from a bilinear map) are genuine,
acknowledged gaps, not exceptions dressed up as intentional — `apply` in
particular is invoked nowhere outside its own teaching level (verified by
grep), which is a real orphaned tool this table should not paper over. A
future pass should either add a real reappearance for each or drop them
from the "core course tools" the coverage invariant is meant to police.
