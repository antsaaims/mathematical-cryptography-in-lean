import Game.Levels.Tutorial
import Game.Levels.ClassicalCiphers
import Game.Levels.ModularArithmetic
import Game.Levels.MatrixAlgebra
import Game.Levels.UOV
import Game.Levels.MinRank

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

No prior experience with Lean, formal proof, or advanced mathematics is required —
just algebra you already know and a willingness to experiment. Every world starts
from the basics and builds up one small, guided step at a time. If you can follow
a proof on paper, you can learn to write one a computer will check for you.

## Worlds

1. **Tutorial World** — Learn the basics of Lean 4: rewriting, equality, and simple automation.
2. **Classical Ciphers World** — The Caesar and Vigenère ciphers as modular arithmetic.
3. **Modular Arithmetic World** — Modular exponentiation and why Diffie-Hellman works.
4. **Matrix Algebra World** — Matrices, determinants, and rank in Mathlib.
5. **UOV World** — The Unbalanced Oil-and-Vinegar signature scheme and its verification.
6. **MinRank World** — The MinRank problem and its cryptographic significance.

Each world follows the **APOS** pedagogical framework (Action → Process → Object →
Schema), and each world unlocks only once its prerequisites are complete — the map
below shows exactly what you need before tackling UOV or MinRank.

    Tutorial -> ClassicalCiphers -> ModularArithmetic -> MatrixAlgebra -> UOV
                                                                        -> MinRank
"

Info "
**Game version:** 1.0

This game was built using the lean4game framework with Lean 4 and Mathlib.

**Credits:** Built for anyone curious about cryptography and formal verification —
students, hobbyists, and researchers alike.

**Found a bug or have feedback?** [Open a GitHub Issue](https://github.com/antsaaims/mathematical-cryptography-in-lean/issues)
"

Languages "en"
CaptionShort "Cryptography in Lean 4"
CaptionLong "Learn mathematical cryptography — UOV, MinRank, and more — while mastering Lean 4 and Mathlib from scratch."

/-
Strict progression: UOV and MinRank must not be reachable before the player has
completed both Modular Arithmetic World and Matrix Algebra World. Dependencies
between worlds are normally inferred automatically from which tactics/lemmas a
later world's proofs reuse, but that inference only sees what's *used*, not the
full intended narrative order — so we pin the whole chain explicitly to
guarantee a single connected, linearly-unlocked world map instead of relying on
inference alone.
-/
Dependency Tutorial → ClassicalCiphers
Dependency ClassicalCiphers → ModularArithmetic
Dependency ModularArithmetic → MatrixAlgebra
Dependency MatrixAlgebra → UOV
Dependency MatrixAlgebra → MinRank

MakeGame
