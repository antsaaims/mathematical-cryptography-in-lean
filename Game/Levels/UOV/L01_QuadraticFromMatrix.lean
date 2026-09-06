import Game.Metadata
import Mathlib.LinearAlgebra.QuadraticForm.Basic
import Mathlib.Tactic.Common

World "UOV"
Level 1

Title "A Quadratic Map Is a Bilinear Map, Applied to Itself"

Introduction
"
## What 'Quadratic' Actually Means

UOV's central map `F` is described as 'quadratic' — but so far in this
course, every map you've formalized (Modular Arithmetic's homomorphisms,
Matrix Algebra's transposes) has been *linear*. Quadratic is different, and
Mathlib makes the difference precise: a quadratic map `Q` comes from a
**bilinear** map `B : M →ₗ[R] M →ₗ[R] N` (a matrix, in coordinates) by
plugging the *same* input into both of its slots: `Q x = B x x`.

This is also exactly why a quadratic map can't be a `LinearMap`: doubling
`x` doesn't double `B x x`, it quadruples it (`B (2x) (2x) = 4 * B x x`),
which breaks linearity outright.

### Your Task

Prove that `B.toQuadraticMap`, evaluated at `x`, really does equal
`B x x`.

### Strategy

Mathlib already has this exact fact — it's essentially the definition.
"

Statement {R M N : Type} [CommSemiring R] [AddCommMonoid M] [Module R M]
    [AddCommMonoid N] [Module R N] (B : LinearMap.BilinMap R M N) (x : M) :
    B.toQuadraticMap x = B x x := by
  Hint "This is Mathlib's own defining fact about `toQuadraticMap`. Type: exact LinearMap.BilinMap.toQuadraticMap_apply B x"
  exact LinearMap.BilinMap.toQuadraticMap_apply B x

Conclusion
"
UOV's central map `F` is, underneath the oil-and-vinegar description, a
collection of these `B x x` expressions — one bilinear (matrix-representable)
form per output coordinate. This is precisely the object the MinRank attack
targets: it searches for a low-rank linear combination of the *matrices*
representing these bilinear forms.

**APOS stage:** Action — a single defining fact, establishing the vocabulary
the rest of this world (and MinRank World) builds on.
"

NewDefinition LinearMap.BilinMap
NewTheorem LinearMap.BilinMap.toQuadraticMap_apply
