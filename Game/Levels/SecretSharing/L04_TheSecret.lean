import Game.Metadata
import Mathlib.Algebra.Polynomial.Eval.Defs
import Mathlib.Tactic.Common

World "SecretSharing"
Level 4

Title "Where the Secret Lives"

Introduction
"
## The Constant Term, in Disguise

A Shamir dealer picks a secret value, builds a polynomial `P` that carries
that secret as `P.eval 0` (the value at input `0`, which no participant's
share ever reveals directly), and hands out `P.eval (v i)` to each
participant `i` at their own point `v i ≠ 0`.

### Your Task

Confirm the simplest case: if the 'secret polynomial' is just the constant
polynomial `C secret` (a Shamir scheme with no participants at all needed —
everyone would see the secret directly), evaluating it at `0` gives back
`secret`.

### Strategy

Unfold the definition, then use the fact that a constant polynomial
evaluates to that constant everywhere.
"

def shamirSecret {F : Type} [Field F] (P : Polynomial F) : F := P.eval 0

Statement (F : Type) [Field F] (secret : F) :
    shamirSecret (Polynomial.C secret) = secret := by
  Hint "Unfold the definition to reach a statement about `Polynomial.eval`. Type: unfold shamirSecret"
  unfold shamirSecret
  Hint "A constant polynomial evaluates to that constant everywhere. Type: exact Polynomial.eval_C"
  exact Polynomial.eval_C

Conclusion
"
`shamirSecret` is genuinely nothing more than 'evaluate at 0' — the
capstone builds the general (non-constant, genuinely-shared) case on top of
exactly this definition.

**APOS stage:** Object — naming 'the secret' as a specific operation on the
dealer's polynomial, not just an informal idea.
"
