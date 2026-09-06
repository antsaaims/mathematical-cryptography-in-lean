import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 2

Title "Old Tools, New Domain"

Introduction
"
## Matrices Are Still Just Algebra

A matrix looks like a brand new kind of object, but each individual *entry*
of a matrix sum is computed exactly the way you'd expect: `(A + B) i j` is
just `A i j + B i j`, an equation between elements of the field `F` you
already know how to handle.

### Your Task

Prove that matrix addition is commutative, entry by entry: for matrices `A`
and `B` and any position `(i, j)`, `(A + B) i j = (B + A) i j`.

### Strategy

Unfold both sides to the underlying field addition with `show`, then finish
with a tactic from Tutorial World.
"

Statement {F : Type} [Field F] {m n : ℕ}
    (A B : Matrix (Fin m) (Fin n) F) (i : Fin m) (j : Fin n) :
    (A + B) i j = (B + A) i j := by
  Hint "This is an equation in `F` about the entries `A i j` and `B i j` — the same field you worked with in Tutorial and Modular Arithmetic World. Type: show A i j + B i j = B i j + A i j"
  show A i j + B i j = B i j + A i j
  Hint "Finish with the same tactic you used to prove commutativity facts before. Type: ring"
  ring

Conclusion
"
Nothing about matrices required a new tactic here — `ring` closed the goal
exactly as it did back in Tutorial World, because underneath the matrix
notation, this was always a statement about ordinary field addition.

The new *object* (a matrix) doesn't retire your old tools; it just gives them
a new place to work. Keep that in mind as this world introduces determinants,
transpose, and rank — the underlying algebra is still the algebra you know.

**APOS stage:** Action — the same mechanical comfort as Tutorial World,
applied to a new kind of object.
"
