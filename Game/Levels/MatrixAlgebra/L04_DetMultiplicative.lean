import Game.Metadata
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Tactic.Common

World "MatrixAlgebra"
Level 4

Title "Multiplicativity of the Determinant"

Introduction
"
## The Multiplicativity Property

A fundamental property of the determinant is:

    det(A * B) = det(A) * det(B)

This means the determinant is a **group homomorphism** from the general linear group
GL_n(F) to the multiplicative group F*.

### Your Task

Given square matrices `A` and `B`, prove that `(A * B).det = A.det * B.det`.

### Strategy

Use the lemma `Matrix.det_mul`, which states `(A * B).det = A.det * B.det`.

### Cryptographic Context

In **UOV**, the public key is P = S * F * T where S, T are invertible
and F is the central map. The multiplicativity of the determinant lets us reason
about the structure of P by decomposing it into its factors.
"

Statement {F : Type} [Field F] {n : ℕ}
    (A B : Matrix (Fin n) (Fin n) F) :
    (A * B).det = A.det * B.det := by
  Hint "Use `Matrix.det_mul` which states (A * B).det = A.det * B.det."
  Hint "Type: exact Matrix.det_mul A B"
  exact Matrix.det_mul A B

Conclusion
"
The multiplicativity of the determinant is one of the most used properties in
algebraic cryptography. It allows us to decompose complex matrix expressions into
products of simpler ones.

**APOS stage:** Process — a structural law about *how determinants behave under an
operation*, not just a single value.
"

