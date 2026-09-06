import Game.Levels.Tutorial
import Game.Levels.ClassicalCiphers
import Game.Levels.PerfectSecrecy
import Game.Levels.FoundationsExam
import Game.Levels.ModularArithmetic
import Game.Levels.GroupsAndOrders
import Game.Levels.NumberTheoryExam
import Game.Levels.PublicKeyCrypto
import Game.Levels.PublicKeyExam
import Game.Levels.SecretSharing
import Game.Levels.SecretSharingExam
import Game.Levels.MatrixAlgebra
import Game.Levels.UOV
import Game.Levels.MinRank
import Game.Levels.FinalExam

Title "Mathematical Cryptography in Lean 4"
Introduction
"
Welcome to **Mathematical Cryptography in Lean 4**!

Ever wondered what makes a cryptographic signature scheme actually *correct* — not
just *seems to work*, but machine-checked, gap-free correct? This game takes you
there. Starting from nothing but curiosity, you'll learn to write real proofs in
**Lean 4**, and use them to build up modern cryptography from the ground up:
classical ciphers, modular arithmetic and Diffie-Hellman, matrix algebra, the
post-quantum **UOV** (Unbalanced Oil and Vinegar) signature scheme, **MinRank**,
and **Support-Minor** models.

No prior experience with Lean or formal proof is required, and Modules 1–2 need
nothing beyond algebra you already know. Modules 3–5 build up real linear algebra
and abstract structures (linear maps, quadratic maps, modules) from scratch as
they're needed — comfortable, but genuinely more than no math background at all, by
the time you reach UOV World. Every world starts from wherever the previous one
left off and builds up one small, guided step at a time. If you can follow
a proof on paper, you can learn to write one a computer will check for you.

## Worlds

**Module 1 — Classical Cryptography & Perfect Secrecy**
1. **Tutorial World** — Learn the basics of Lean 4: rewriting, equality, and simple automation.
2. **Classical Ciphers World** — Caesar, substitution, and Vigenère ciphers as modular arithmetic.
3. **Perfect Secrecy World** — The one-time pad, and why 'invertible' isn't the same as 'secure.'
4. **Foundations Exam** — A cumulative checkpoint before moving on.

**Module 2 — Number Theory**
5. **Modular Arithmetic World** — Modular exponentiation, Fermat's Little Theorem, Euler's
   Theorem, and why Diffie-Hellman works.
6. **Groups and Orders World** — Element order, the Chinese Remainder Theorem, and the
   generator setup public-key protocols publish.
7. **Number Theory Exam** — A cumulative checkpoint. The course branches into three
   independent tracks after this.

**Module 3 — Public-Key Cryptography** (independent of Modules 4 and 5)
8. **Public-Key Cryptography World** — RSA and ElGamal, proved correct.
9. **Public-Key Exam** — A cumulative checkpoint.

**Module 4 — Secret Sharing** (independent of Modules 3 and 5)
10. **Secret Sharing World** — Lagrange interpolation and Shamir's threshold scheme.
11. **Secret Sharing Exam** — A cumulative checkpoint.

**Module 5 — Linear Algebra & Post-Quantum Cryptography**
12. **Matrix Algebra World** — Matrices, determinants, rank, and submatrices in Mathlib.
13. **UOV World** — The Unbalanced Oil-and-Vinegar signature scheme, its verification, and
    (using Module 4's tools) why its signing key can be split across several parties.
14. **MinRank World** — The MinRank problem and its cryptographic significance.
15. **Final Exam** — A comprehensive, cumulative check spanning every module.

Each world follows the **APOS** pedagogical framework (Action → Process → Object →
Schema). Every world unlocks only once its prerequisites are complete, and short
'Exam' worlds check that earlier tools are still at hand before new material builds
on them. Modules 3, 4, and 5 don't depend on each other — play them in any order —
and everything converges at the Final Exam.

    Tutorial -> ClassicalCiphers -> PerfectSecrecy -> FoundationsExam
             -> ModularArithmetic -> GroupsAndOrders -> NumberTheoryExam, and then:

      NumberTheoryExam -> PublicKeyCrypto -> PublicKeyExam
      NumberTheoryExam -> SecretSharing -> SecretSharingExam
      NumberTheoryExam -> MatrixAlgebra -> MinRank
      NumberTheoryExam -> MatrixAlgebra -> UOV (also needs SecretSharingExam)

      PublicKeyExam, MinRank, and UOV all lead to -> FinalExam
"

Info "
**Game version:** 1.0

This game was built using the lean4game framework with Lean 4 and Mathlib.

**About this game:** This game was created by Antsa Pierrottet
(antsaeducontent.com) as a course project for *Introduction to
Computer-Assisted Proof* at Clemson University, taught by Professor Yuyuan
Ouyang. It was built with the assistance of Gemini (ideation), an
open-weight GLM 5.3 model hosted locally at Clemson University (source
scouting), and Claude (prose drafting). The author actively maintains the
game and reviews its content for accuracy.

**Course resources:** the curriculum follows two free textbooks — Bellare
and Rogaway's *Introduction to Modern Cryptography*
([PDF](https://web.cs.ucdavis.edu/~rogaway/classes/227/spring05/book/main.pdf))
and Nigel Smart's *Cryptography: An Introduction*, 3rd ed.
([author's page](https://nigelsmart.github.io/Crypto_Book/), free to copy and
redistribute) — plus two sources specifically for the multivariate/
post-quantum worlds: Ding and Petzoldt's survey *Current State of
Multivariate Cryptography*
([free copy](https://www.researchgate.net/publication/319170467_Current_State_of_Multivariate_Cryptography))
and Pierre Varjabedian's 2026 PhD thesis *Multivariate and Post-Quantum
Cryptography* ([open access via HAL](https://theses.hal.science/tel-05639858v1)).
See `RESOURCES.md` in the repository for details on which world each feeds.

**Found a bug or have feedback?** [Open a GitHub Issue](https://github.com/antsaaims/mathematical-cryptography-in-lean/issues)
"

Languages "en"
CaptionShort "Cryptography in Lean 4"
CaptionLong "Learn mathematical cryptography — UOV, MinRank, and more — while mastering Lean 4 and Mathlib from scratch."

/-
Dependencies between worlds are normally inferred automatically from which
tactics/lemmas a later world's proofs reuse, but that inference only sees
what's *used*, not the full intended narrative order or the deliberate exam
checkpoints — so we pin the whole graph explicitly instead of relying on
inference alone.

This graph deliberately branches: Public-Key Cryptography, Secret Sharing,
and Matrix Algebra (leading to UOV and MinRank) are three independent
tracks that all unlock together once the Number Theory Exam is done, and
can be played in any order. UOV additionally requires the Secret Sharing
Exam specifically (its final capstone needs Secret Sharing World's
Lagrange interpolation). Everything converges at the Final Exam, which
needs the Public-Key Exam, UOV, and MinRank all complete.
-/
Dependency Tutorial → ClassicalCiphers
Dependency ClassicalCiphers → PerfectSecrecy
Dependency PerfectSecrecy → FoundationsExam
Dependency FoundationsExam → ModularArithmetic
Dependency ModularArithmetic → GroupsAndOrders
Dependency GroupsAndOrders → NumberTheoryExam
Dependency NumberTheoryExam → PublicKeyCrypto
Dependency PublicKeyCrypto → PublicKeyExam
Dependency NumberTheoryExam → SecretSharing
Dependency SecretSharing → SecretSharingExam
Dependency NumberTheoryExam → MatrixAlgebra
Dependency MatrixAlgebra → UOV
Dependency SecretSharingExam → UOV
Dependency MatrixAlgebra → MinRank
Dependency PublicKeyExam → FinalExam
Dependency UOV → FinalExam
Dependency MinRank → FinalExam

MakeGame
