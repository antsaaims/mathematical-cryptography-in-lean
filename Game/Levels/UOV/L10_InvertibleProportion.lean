import Game.Metadata
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Tactic.Common

World "UOV"
Level 10

Title "Invertible, in One More Way"

Introduction
"
## Three Descriptions, Now Down to Two Words

Matrix Algebra World's capstone connected 'invertible' to 'determinant is a
unit.' Over a field, 'a nonzero element' and 'a unit' are the same thing —
so that connection collapses to something even more concrete: a matrix is
invertible exactly when its determinant is *nonzero*.

This matters for **Threshold UOV** (Varjabedian's thesis, Ch. 5): splitting
a signing key across several parties requires jointly-generated random
matrices to be invertible, and 'nonzero determinant' is the concrete
condition anyone can check. (The thesis goes further — computing exactly
*what fraction* of matrices are invertible, to bound how often the protocol
needs to retry — but that proportion calculation is beyond what this
course formalizes; the equivalence itself is not.)

### Your Task

Prove `IsUnit A ↔ A.det ≠ 0` for a square matrix `A` over a field.

### Strategy

Chain Matrix Algebra World's capstone fact with the field-specific fact
that a unit is exactly a nonzero element.
"

Statement {F : Type} [Field F] {n : ℕ} (A : Matrix (Fin n) (Fin n) F) :
    IsUnit A ↔ A.det ≠ 0 := by
  Hint "Combine Matrix Algebra World's `Matrix.isUnit_iff_isUnit_det` with the fact that, in a field, a unit is exactly a nonzero element. Type: rw [Matrix.isUnit_iff_isUnit_det, isUnit_iff_ne_zero]"
  rw [Matrix.isUnit_iff_isUnit_det, isUnit_iff_ne_zero]

Conclusion
"
'Invertible,' 'nonzero determinant,' and 'unit determinant' are now one
proven fact, viewed three ways ('full rank' is the same fact again, by a
standard equivalence this course states but doesn't formalize). Threshold
UOV's random shared matrices need to land in this invertible set — and
checking that is exactly a determinant computation, nothing more exotic.

**APOS stage:** Object — chaining two equivalences into a third, more
concrete one.
"
