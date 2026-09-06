import Game.Metadata
import Mathlib.Tactic.Common
import Mathlib.Tactic.Ring

World "UOV"
Level 3

Title "Quadratic Form Identity"

Introduction
"
## Quadratic Forms

A **quadratic form** is a homogeneous polynomial of degree 2. In UOV, the central map
F consists of quadratic polynomials in the oil and vinegar variables.

A basic identity: for any a, b in a commutative ring,

    (a + b)^2 = a^2 + 2ab + b^2

### Your Task

Prove this identity using `ring`.

### Why This Matters

The UOV central map has the form:

    F_k(o, v) = Sum alpha_ij o_i v_j + Sum beta_ij v_i v_j

Each component is a quadratic form. Verifying the correctness of UOV reduces to
proving polynomial identities like the one above.
"

Statement {R : Type} [CommRing R] (a b : R) :
    (a + b)^2 = a^2 + 2*a*b + b^2 := by
  Hint "The `ring` tactic proves this automatically. Type: ring"
  ring

Conclusion
"
The expansion of (a+b)^2 is the simplest non-trivial quadratic identity.
In UOV, the central map and public key are systems of such quadratic forms,
and `ring` can verify their algebraic properties.

**APOS stage:** Action — a single, direct computation.
"
