import Game.Metadata
import Game.Levels.UOV.L10_InvertibleProportion
import Mathlib.Tactic.Common

World "FinalExam"
Level 3

Title "Final Capstone: What MinRank Is Really Looking For"

Introduction
"
## The Whole Course, in One Contrapositive

MinRank World's every level was, underneath the specifics, about matrices
with `det = 0` — the singular, structured, attacker-exploitable case. UOV
World's Level 10 proved invertibility is *equivalent* to nonzero
determinant. Put the two together.

### Your Task

Prove that a matrix with determinant `0` is never invertible.

### Strategy

The rewrite is the contrapositive of a fact you've already proved. Closing
the goal afterwards needs one genuinely new move, not used anywhere earlier
in this course: `¬ P` unfolds to `P → False`, so you prove a negation by
*assuming* the thing you're negating and deriving a contradiction —
`fun (assumption : P) => (derive False here)`. Here, `P` is `A.det ≠ 0`,
which directly contradicts `h : A.det = 0`.
"

Statement {F : Type} [Field F] {n : ℕ} (A : Matrix (Fin n) (Fin n) F)
    (h : A.det = 0) : ¬ IsUnit A := by
  Hint (hidden := true) "Rewrite using the invertible-iff-nonzero-determinant equivalence from UOV World."
  rw [Matrix.isUnit_iff_isUnit_det, isUnit_iff_ne_zero]
  Hint (hidden := true) "The goal `¬ A.det ≠ 0` unfolds to `(A.det ≠ 0) → False`. Assume `hne : A.det ≠ 0` and derive `False` by applying it to `h`. Type: exact fun hne => hne h"
  exact fun hne => hne h

Conclusion
"
Congratulations — you've completed Mathematical Cryptography in Lean 4!

Trace the thread all the way back: Tutorial World's `rw` and `ring`
survived, unchanged, into a quotient ring introduced in the course's final
world. Classical Ciphers World's 'invertible cipher' became Perfect
Secrecy World's 'unique key,' Secret Sharing World's 'unique interpolating
polynomial,' and UOV World's 'invertible signing map.' Modular Arithmetic
World's Euler's Theorem, unchanged, is the entire correctness argument for
RSA. And this very last fact — det = 0 means not invertible — is the
precise, one-line reason MinRank is a real attack on real cryptosystems:
it searches for exactly the matrices this proof says can never be trusted.

None of it was ever separate courses in disguise. It was one course, about
one idea — invertibility, and what its absence means — examined from
enough angles that a single Lean fact could travel through all of them.

**APOS stage:** Schema — the entire course's central thread, made explicit
in its final line.
"
