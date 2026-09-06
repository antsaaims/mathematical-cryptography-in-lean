import Game.Metadata
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Tactic.Common

World "SecretSharing"
Level 1

Title "Interpolation Reproduces Its Own Data"

Introduction
"
## Fitting a Curve Through Points

Given a finite set of 'input' points `s`, a way to place them on the number
line `v : ι → F`, and a target 'output' value at each one, `r : ι → F`,
Mathlib's `Lagrange.interpolate s v r` builds the (unique, lowest-degree)
polynomial passing through every one of those points. This is the algebraic
engine of **Shamir's Secret Sharing**.

The most basic thing such a polynomial had better do: actually pass through
the points it was built from.

### Your Task

Prove that the interpolating polynomial, evaluated at node `v i`, gives
back `r i`.

### Strategy

Mathlib already has this exact fact.
"

Statement {F : Type} [Field F] {ι : Type} [DecidableEq ι]
    (s : Finset ι) (v r : ι → F) (i : ι)
    (hvs : Set.InjOn v s) (hi : i ∈ s) :
    Polynomial.eval (v i) (Lagrange.interpolate s v r) = r i := by
  Hint "This is exactly Mathlib's statement of the fact. Type: exact Lagrange.eval_interpolate_at_node r hvs hi"
  exact Lagrange.eval_interpolate_at_node r hvs hi

Conclusion
"
The interpolating polynomial genuinely fits every one of its input points.
This will let a Shamir dealer hand out shares as *values* of a secret
polynomial and be certain that reconstructing from enough of them recovers
a polynomial passing through the same points.

**APOS stage:** Action — a single, direct application of a defining fact.
"

NewDefinition Lagrange.interpolate
